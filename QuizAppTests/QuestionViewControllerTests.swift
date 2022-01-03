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
        let sut = QuestionViewController(question: "Q1", options: [])
        _ = sut.view
        XCTAssertEqual(sut.headerLabel.text, "Q1")
    }
    
    func test_viewDidLoad_withNoOptions_rendersZeroOptions() {
        let sut = QuestionViewController(question: "Q1", options: [])
        _ = sut.view
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 0)
    }
    
    func test_viewDidLoad_withOneOption_rendersOneOption() {
        let sut = QuestionViewController(question: "Q1", options: ["A1"])
        _ = sut.view
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 1)
    }
    
    func test_viewDidLoad_withOneOption_rendersOneOptionText() {
        let sut = QuestionViewController(question: "Q1", options: ["A1"])
        
        _ = sut.view
        
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = sut.tableView.dataSource?.tableView(sut.tableView, cellForRowAt: indexPath)
        
        
        XCTAssertEqual(cell?.textLabel?.text, "A1")
    }
}
