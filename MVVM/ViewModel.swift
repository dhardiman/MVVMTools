//
//  ViewModel.swift
//  MVVM
//
//  Created by Dave Hardiman on 22/03/2016.
//  Copyright © 2016 David Hardiman. All rights reserved.
//

import UIKit

/**
 *  Protocol indicating an entity can be used as a view model
 */
protocol ViewModel {
    /// The generic type of the model being displayed
    associatedtype ModelType

    /// The stored model property for the ViewModel
    var model: ModelType? { get set }
}
