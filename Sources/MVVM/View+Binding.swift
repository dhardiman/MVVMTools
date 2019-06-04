//
//  View+Binding.swift
//  MVVM
//
//  Created by Dave Hardiman on 10/04/2016.
//  Copyright © 2016 David Hardiman. All rights reserved.
//

import Foundation
import ReactiveKit
import Bond

public extension View {
    /**
     Binds an observable object to a label

     - parameter observable: The observable to bind
     - parameter label:      The label to bind to
     */
    func bind(_ observable: Property<String>, toLabel label: UILabel) {
        observable.bind(to: label.reactive.text)
    }

    /**
     Binds an observable object to a label

     - parameter observable: The observable to bind
     - parameter label:      The label to bind to
     */
    func bind(_ observable: Property<String?>, toLabel label: UILabel) {
        observable.bind(to: label.reactive.text)
    }
    
    /**
     Binds an observable object to an image view
     
     - parameter observable: The observable to bind
     - parameter imageView:  The image view to bind to
     */
    func bind(_ observable: Property<UIImage?>, toImageView imageView: UIImageView) {
        observable.bind(to: imageView.reactive.image)
    }
    
    /**
     Binds an observable object to an image view
     
     - parameter observable: The observable to bind
     - parameter imageView:  The image view to bind to
     */
    func bind(_ observable: Property<UIImage>, toImageView imageView: UIImageView) {
        observable.bind(to: imageView.reactive.image)
    }

    /**
     Updates the view model with the latest model object

     - parameter model: The model to update to
     */
    func updateViewModel(_ model: ViewModelType.ModelType?) {
        viewModel.model = model
    }
}
