//
//  CommonControls.swift
//  PokeApp
//
//  Created by Intellisys on 24/2/21.
//

import UIKit

final class CommonControls {
    
    /// Called for generate an UITableView
    /// - Parameters:
    ///   - style: the style for the table view
    ///   - cellClass: the cell type for register
    ///   - identifier: identifier for reusable cell
    /// - Returns: UIButton
    static func generateTableView(style: UITableView.Style, cellClass: AnyClass, identifier: String) -> UITableView {
        
        let tableView = UITableView(frame: .zero, style: style)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(cellClass, forCellReuseIdentifier: identifier)
        tableView.tableFooterView = UIView(frame: .zero)
        return tableView
    }
}
