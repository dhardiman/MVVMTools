//
//  ViewBindingTests.swift
//  MVVMTests
//
//  Created by Dave Hardiman on 10/04/2016.
//  Copyright © 2016 David Hardiman. All rights reserved.
//

import XCTest
import ReactiveKit
import Nimble
@testable import MVVM

class TestViewModel: ViewModel {
    internal var model: String? {
        didSet {
            observableString.value = model ?? ""
        }
    }

    let observableString = Property("")
}

class TestView: UIView, View {
    var viewModel: TestViewModel! = TestViewModel()
}

class ViewBindingTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testItIsPossibleToBindAValueToALabel() {
        let testView = TestView()
        let label = UILabel()
        testView.addSubview(label)
        testView.bind(testView.viewModel.observableString, toLabel: label)
        testView.updateViewModel("test string")
        expect(label.text).to(equal("test string"))
    }
}
