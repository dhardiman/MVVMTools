//
//  View+Binding.swift
//  MVVM
//
//  Created by Dave Hardiman on 10/04/2016.
//  Copyright © 2016 David Hardiman. All rights reserved.
//

import Foundation
import Bond

public extension View {
    /**
     Binds an observable object to a label

     - parameter observable: The observable to bind
     - parameter label:      The label to bind to
     */
    func bind(observable: Observable<String>, toLabel label: UILabel) {
        observable.bindTo(label.bnd_text)
    }

    /**
     Updates the view model with the latest model object

     - parameter model: The model to update to
     */
    func updateViewModel(model: ViewModelType.ModelType?) {
        viewModel.model = model
    }
}