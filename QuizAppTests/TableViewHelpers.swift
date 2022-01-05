//
//  TableViewHelpers.swift
//  QuizAppTests
//
//  Created by Paulo Silva on 04/01/2022.
//

import UIKit

extension UITableView {
    func cell(at row: Int) -> UITableViewCell? {
        return dataSource?.tableView(self, cellForRowAt: IndexPath(row: row, section: 0))
    }
    
    func title(at row: Int) -> String? {
        return cell(at: row)?.textLabel?.text
    }
    
    func select(row: Int) {
        let indexPath = IndexPath(row: row, section: 0)
        // mimic the table view behavior
        selectRow(at: indexPath, animated: false, scrollPosition: .none)
        delegate?.tableView?(self, didSelectRowAt: indexPath)
    }
    
    func deselect(row: Int) {
        let indexPath = IndexPath(row: row, section: 0)
        // mimic the table view behavior
        deselectRow(at: indexPath, animated: false)
        delegate?.tableView?(self, didDeselectRowAt: indexPath)
    }
    
}
