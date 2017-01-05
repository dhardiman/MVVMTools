//
//  CollectionViewCellSourceTests.swift
//  MVVM
//
//  Created by Stephen Anthony on 05/01/2017.
//  Copyright © 2017 David Hardiman. All rights reserved.
//

import XCTest
import Nimble
import ReactiveKit
@testable import MVVM

class TestNibCollectionViewCell: UICollectionViewCell, ViewCell {
    let viewModel: TestViewModel = TestViewModel()
    @IBOutlet var textLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bind(viewModel.observableString, toLabel: textLabel)
    }
}

class TestCodeCollectionViewCell: UICollectionViewCell, ViewCell {
    let viewModel: TestViewModel = TestViewModel()
    let textLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        bind(viewModel.observableString, toLabel: textLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class TestCollectionViewController: UICollectionViewController, CollectionViewCellSource {
    typealias CellViewModelType = TestViewModel
    
    let items = ["Test Item"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerClass(TestCodeCollectionViewCell.self)
        registerNib(TestNibCollectionViewCell.self, bundle: Bundle(for: type(of: self)))
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
}

class CollectionViewCellSourceTests: XCTestCase {
    
    var viewController: TestCollectionViewController!
    
    override func setUp() {
        super.setUp()
        viewController = TestCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())
        _ = viewController.view
    }
    
    override func tearDown() {
        viewController = nil
        super.tearDown()
    }
    
    func testItIsPossibleToDequeueAConfiguredCell() {
        let cell = viewController.cell(forItem: viewController.items.first!, at: IndexPath(item: 0, section: 0)) as TestCodeCollectionViewCell
        expect(cell.textLabel.text).to(equal("Test Item"))
    }
    
    func testItIsPossibleToDequeueACellLoadedFromANib() {
        let cell = viewController.cell(forItem: viewController.items.first!, at: IndexPath(item: 0, section: 0)) as TestNibCollectionViewCell
        expect(cell.textLabel.text).to(equal("Test Item"))
    }
}
