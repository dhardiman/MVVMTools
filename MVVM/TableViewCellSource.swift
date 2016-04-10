//
//  TableViewCellSource.swift
//  MVVM
//
//  Created by Dave Hardiman on 22/03/2016.
//  Copyright © 2016 David Hardiman. All rights reserved.
//

import UIKit

/**
 *  A `View` that can be reused
 */
protocol ViewCell: View {
    static var defaultReuseIdentifier: String { get }
}

// MARK: - Default implementation of reuse identifier for table view cells
extension ViewCell where Self: UITableViewCell {
    static var defaultReuseIdentifier: String {
        return String(self)
    }
}

/**
 *  A protocol that describes a source for MVVM compatible table view cells
 */
protocol TableViewCellSource: UITableViewDataSource {
    /// The type of the view model being used by the cells. Used as a type 
    /// constraint in the extension below
    associatedtype CellViewModelType: ViewModel

    /// The table view being supplied
    var tableView: UITableView! { get set }
}

extension TableViewCellSource {
    /**
     Registers a table cell by nib name with the current table view

     - parameter _: The type of the cell being registered
     */
    func register<T: UITableViewCell where T: ViewCell>(_: T.Type) {
        let nib = UINib(nibName: (String(T)), bundle: nil)
        tableView?.registerNib(nib, forCellReuseIdentifier: T.defaultReuseIdentifier)
    }

    /**
     Retgisters a table cell by its class

     - parameter _: The type of the cell being registered
     */
    func registerClass<T: UITableViewCell where T: ViewCell>(_: T.Type) {
        tableView?.registerClass(T.self, forCellReuseIdentifier: T.defaultReuseIdentifier)
    }

    /**
     Dequeues a cell from the current table view and configures the cell's view 
     model with the specified item

     - parameter item:         The item for the cell to display
     - parameter atIndexPath:  The indexPath to dequeue the cell for

     - returns: A configured cell
     */
    func cell<VC: ViewCell where VC.ViewModelType == Self.CellViewModelType, VC: UITableViewCell>(forItem item: CellViewModelType.ModelType, atIndexPath: NSIndexPath) -> VC {
        guard let cell = tableView?.dequeueReusableCellWithIdentifier(VC.defaultReuseIdentifier, forIndexPath: atIndexPath) as? VC else {
            fatalError("No cell registered for \(VC.defaultReuseIdentifier)")
        }
        cell.viewModel.model = item
        return cell
    }
}
