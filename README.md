# MVVM Tools
This is a simple collection of protocols and utilities for making MVVM easier
with Swift. It is intentionally lightweight and fairly opinionated. It's
intended to be used alongside [ReactiveKit](https://github.com/ReactiveKit/ReactiveKit).

## Getting started
This framework can be added to you project easily using Carthage:

```
github "dhardiman/MVVMTools"
```

The framework has Bond as a dependency, which will be brought in with Carthage
as well.

## How to use it
Primarily this framework consists of two very simple protocols, `View` and
`ViewModel`. `ViewModel` is simply a protocol with a generic `model` property,
and `View` is a class that has a `viewModel` property.

#### `ViewModel`
The intention of this class is that it would have a series of Bond `Observable`
properties to make the data in its `model` available to the view that owns it.
Add a `didSet` observer to the model property in the implementation and update
the `value`s of those observable properties.

#### `View`
The view should instantiate its view model at some point during its lifecycle,
or possibly have it injected by something else. During `viewDidLoad` or
somewhere equally suitable, bind the view's user interface to the view model's
observable properties. There's a convenience method to allow binding a string
property (which should be the most common type for the view model's properties)
to a label. Just call `bind(viewModel.property, toLabel: myLabel)`. When the
data for the view model is available, likely from a network request or database
query, updating the view model's `model` property will then automatically update
the UI.

### `TableViewCellSource`
This contains some convenience methods to allow the same pattern for table view
cells. By creating the view model during the cell's creation, perhaps in
`awakeFromNib` along with the bindings, when dequeing the cell, simply setting
the cell's `viewModel`'s `model` property, the UI configures itself as required.

## License
[MIT](LICENSE)
