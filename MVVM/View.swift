//
//  View.swift
//  MVVM
//
//  Created by Dave Hardiman on 10/04/2016.
//  Copyright © 2016 David Hardiman. All rights reserved.
//

import Foundation

/// Protocol indicating an entity can be used as a view and therefore consume 
/// a view model. This is intended to be implemented by a `UIView` or
/// `UIViewController`, hence the `class` constraint to avoid requirements for
/// marking methods as `mutating`.
public protocol View: class {
    /// The generic type of the view model being consumed
    associatedtype ViewModelType: ViewModel

    /* The view model being consumed. The view is responsible for
     * instantiating this during initialisation.
     * It then needs to fetch the model during its lifecycle, perhaps from a 
     * network request, or populate the model for the view model with a value 
     * passed in via a segue.
     */
    var viewModel: ViewModelType { get }
}
