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
protocol View: class {
    /// The generic type of the view model being consumed
    associatedtype ViewModelType: ViewModel

    /* The view model being consumed. The view is most likely responsible for 
     * instantiating this at some point during its lifecycle.
     * For example, a `UIViewController` would likely instantiate its view 
     * model during `viewDidLoad()`, and then fetch the model from a network 
     * request, or populate the model for the view model with a value passed in 
     * via a segue.
     */
    var viewModel: ViewModelType! { get set }
}
