//
//  TableCellSourceTests.swift
//  MVVM
//
//  Created by Dave Hardiman on 10/04/2016.
//  Copyright © 2016 David Hardiman. All rights reserved.
//

import XCTest
import Nimble
import ReactiveKit
@testable import MVVM

class TestNibTableViewCell: UITableViewCell, ViewCell {
    var viewModel: TestViewModel! = TestViewModel()

    override func awakeFromNib() {
        super.awakeFromNib()
        bind(viewModel.observableString, toLabel: textLabel!)
    }
}

class TestCodeTableViewCell: UITableViewCell, ViewCell {
    var viewModel: TestViewModel! = TestViewModel()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        bind(viewModel.observableString, toLabel: textLabel!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class TestTableViewController: UITableViewController, TableViewCellSource {
    typealias CellViewModelType = TestViewModel

    let items = ["Test Item"]

    override func viewDidLoad() {
        super.viewDidLoad()
        registerClass(TestCodeTableViewCell.self)
        registerNib(TestNibTableViewCell.self, bundle: Bundle(for: type(of: self)))
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
}

class TableCellSourceTests: XCTestCase {
    var viewController: TestTableViewController!

    override func setUp() {
        super.setUp()
        viewController = TestTableViewController(style: .plain)
        _ = viewController.view
    }
    
    override func tearDown() {
        viewController = nil
        super.tearDown()
    }

    func testItIsPossibleToDequeueAConfiguredCell() {
        let cell = viewController.cell(forItem: viewController.items.first!, at: IndexPath(row: 0, section: 0)) as TestCodeTableViewCell
        expect(cell.textLabel!.text).to(equal("Test Item"))
    }

    func testItIsPossibleToDequeueACellLoadedFromANib() {
        let cell = viewController.cell(forItem: viewController.items.first!, at: IndexPath(row: 0, section: 0)) as TestNibTableViewCell
        expect(cell.textLabel!.text).to(equal("Test Item"))
    }

}
