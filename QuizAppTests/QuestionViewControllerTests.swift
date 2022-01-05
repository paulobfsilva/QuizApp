//
//  QuestionViewControllerTests.swift
//  QuizAppTests
//
//  Created by Paulo Silva on 02/01/2022.
//

import Foundation
import XCTest
@testable import QuizApp

// to test VCs we need to load the view, so it's in the ready to be rendered on screen
// we need to start the view lifecycle exactly
// according to the documentation, there are certain things that are set up once the view is
// accessed for the first time, so, instead of calling viewDidLoad directly, we should opt for
// being good citizens 

class QuestionViewControllerTest: XCTestCase {
    
    func test_viewDidLoad_rendersQuestionHeaderText() {
        XCTAssertEqual(makeSUT(question: "Q1").headerLabel.text, "Q1")
    }
    
    func test_viewDidLoad_rendersOptions() {
        XCTAssertEqual(makeSUT(options: []).tableView.numberOfRows(inSection: 0), 0)
        XCTAssertEqual(makeSUT(options: ["A1"]).tableView.numberOfRows(inSection: 0), 1)
        XCTAssertEqual(makeSUT(options: ["A1", "A2"]).tableView.numberOfRows(inSection: 0), 2)
    }
    
    func test_viewDidLoad_renderOptionsText() {
        XCTAssertEqual(makeSUT(options: ["A1", "A2"]).tableView.title(at: 0), "A1")
        XCTAssertEqual(makeSUT(options: ["A1", "A2"]).tableView.title(at: 1), "A2")
    }
    
    func test_optionSelected_withSingleSelection_notifiesDelegateWithLastSelection() {
        // given
        var receivedAnswer = [String]()
        let sut = makeSUT(options: ["A1", "A2"]) { receivedAnswer = $0 }
        // when: select the cell
        sut.tableView.select(row: 0)
        // then
        XCTAssertEqual(receivedAnswer, ["A1"])

        // when: change option
        sut.tableView.select(row: 1)
        // then
        XCTAssertEqual(receivedAnswer, ["A2"])
        
    }
    
    func test_optionDeselected_withSingleSelection_doesNotNotifyDelegateWithEmptySelection() {
        // given
        var callbackCount = 0
        let sut = makeSUT(options: ["A1", "A2"]) { _ in
            callbackCount += 1
        }
        // when: select the cell
        sut.tableView.select(row: 0)
        // then
        XCTAssertEqual(callbackCount, 1)

        // when: change option
        sut.tableView.deselect(row: 0)
        // then
        XCTAssertEqual(callbackCount, 1)
    }
    
    func test_optionSelected_withMultipleSelectionEnabled_notifiesDelegateSelection() {
        // given
        var receivedAnswer = [String]()
        let sut = makeSUT(options: ["A1", "A2"]) { receivedAnswer = $0 }
        // when: select the cell
        sut.tableView.allowsMultipleSelection = true
        sut.tableView.select(row: 0)
        XCTAssertEqual(receivedAnswer, ["A1"])
        // multiple selection accumulating options
        sut.tableView.select(row: 1)
        XCTAssertEqual(receivedAnswer, ["A1", "A2"])
    }
    
    func test_optionDeselected_withMultipleSelectionEnabled_notifiesDelegate() {
        // given
        var receivedAnswer = [String]()
        let sut = makeSUT(options: ["A1", "A2"]) { receivedAnswer = $0 }
        // when: select the cell
        sut.tableView.allowsMultipleSelection = true
        sut.tableView.select(row: 0)
        XCTAssertEqual(receivedAnswer, ["A1"])
        // multiple selection accumulating options
        sut.tableView.deselect(row: 0)
        XCTAssertEqual(receivedAnswer, [])
    }
    
    //    MARK: - Helpers
    func makeSUT(question: String = "",
                 options: [String] = [],
                 selection: @escaping ([String]) -> Void = { _ in }) -> QuestionViewController {
        let sut = QuestionViewController(question: question, options: options, selection: selection)
        _ = sut.view
        return sut
    }
        
}

