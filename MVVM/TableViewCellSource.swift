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
public protocol ViewCell: View {
    static var defaultReuseIdentifier: String { get }
}

// MARK: - Default implementation of reuse identifier for table view cells
public extension ViewCell where Self: UITableViewCell {
    static var defaultReuseIdentifier: String {
        return String(describing: self)
    }
}

/**
 *  A protocol that describes a source for MVVM compatible table view cells
 */
public protocol TableViewCellSource: UITableViewDataSource {
    /// The type of the view model being used by the cells. Used as a type 
    /// constraint in the extension below
    associatedtype CellViewModelType: ViewModel

    /// The table view being supplied
    var tableView: UITableView! { get set }
}

public extension TableViewCellSource {
    /**
     Registers a table cell by nib name with the current table view

     - parameter _: The type of the cell being registered
     */
    func registerNib<T: UITableViewCell>(_: T.Type, bundle: Bundle? = nil) where T: ViewCell {
        let nib = UINib(nibName: (String(describing: T.self)), bundle: bundle)
        tableView?.register(nib, forCellReuseIdentifier: T.defaultReuseIdentifier)
    }

    /**
     Retgisters a table cell by its class

     - parameter _: The type of the cell being registered
     */
    func registerClass<T: UITableViewCell>(_: T.Type) where T: ViewCell {
        tableView?.register(T.self, forCellReuseIdentifier: T.defaultReuseIdentifier)
    }

    /**
     Dequeues a cell from the current table view and configures the cell's view 
     model with the specified item

     - parameter item:         The item for the cell to display
     - parameter atIndexPath:  The indexPath to dequeue the cell for

     - returns: A configured cell
     */
    func cell<VC: ViewCell>(forItem item: CellViewModelType.ModelType, at indexPath: IndexPath) -> VC
        where VC.ViewModelType == Self.CellViewModelType, VC: UITableViewCell {
        guard let cell = tableView?.dequeueReusableCell(withIdentifier: VC.defaultReuseIdentifier, for: indexPath) as? VC else {
            fatalError("No cell registered for \(VC.defaultReuseIdentifier)")
        }
        cell.viewModel.model = item
        return cell
    }
}
