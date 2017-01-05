//
//  CollectionViewCellSource.swift
//  MVVM
//
//  Created by Stephen Anthony on 05/01/2017.
//  Copyright © 2017 David Hardiman. All rights reserved.
//

import Foundation

// MARK: - Default implementation of reuse identifier for collection view cells
public extension ViewCell where Self: UICollectionViewCell {
    static var defaultReuseIdentifier: String {
        return String(describing: self)
    }
}

/**
 *  A protocol that describes a source for MVVM compatible collection view cells
 */
public protocol CollectionViewCellSource: UICollectionViewDataSource {
    /// The type of the view model being used by the cells. Used as a type
    /// constraint in the extension below
    associatedtype CellViewModelType: ViewModel
    
    /// The collection view being supplied
    var collectionView: UICollectionView? { get set }
}

public extension CollectionViewCellSource {
    /**
     Registers a collection cell by nib name with the current collection view
     
     - parameter _: The type of the cell being registered
     */
    func registerNib<T: UICollectionViewCell>(_: T.Type, bundle: Bundle? = nil) where T: ViewCell {
        let nib = UINib(nibName: (String(describing: T.self)), bundle: bundle)
        collectionView?.register(nib, forCellWithReuseIdentifier: T.defaultReuseIdentifier)
    }
    
    /**
     Registers a collection view cell by its class
     
     - parameter _: The type of the cell being registered
     */
    func registerClass<T: UICollectionViewCell>(_: T.Type) where T: ViewCell {
        collectionView?.register(T.self, forCellWithReuseIdentifier: T.defaultReuseIdentifier)
    }
    
    /**
     Dequeues a cell from the current collection view and configures the cell's
     view model with the specified item
     
     - parameter item:         The item for the cell to display
     - parameter atIndexPath:  The indexPath to dequeue the cell for
     
     - returns: A configured cell
     */
    func cell<VC: ViewCell>(forItem item: CellViewModelType.ModelType, at indexPath: IndexPath) -> VC
        where VC.ViewModelType == Self.CellViewModelType, VC: UICollectionViewCell {
            guard let cell = collectionView?.dequeueReusableCell(withReuseIdentifier: VC.defaultReuseIdentifier, for: indexPath) as? VC else {
                fatalError("No cell registered for \(VC.defaultReuseIdentifier)")
            }
            cell.viewModel.model = item
            return cell
    }
}
