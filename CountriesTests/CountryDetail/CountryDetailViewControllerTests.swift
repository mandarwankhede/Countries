//
//  CountryDetailViewControllerTests.swift
//  CountriesTests
//
//  Created by Mandar Wankhede New on 02/03/20.
//  Copyright © 2020 Mandar Wankhede. All rights reserved.
//

import XCTest
@testable import Countries

class MockProgressHUD: MBProgressHUD {
    static var showHUDAddedTo = false

    override class func showAdded(to view: UIView, animated: Bool) -> Self {
        showHUDAddedTo = true
        return MockProgressHUD() as! Self
    }
}

class CountryDetailViewControllerTests: XCTestCase {
    var mockCountryPresenter: MockCountryPresenter!
    var sut: CountryDetailViewController!

    override func setUp() {
        mockCountryPresenter = MockCountryPresenter()
        setUpViewController()
    }

    private func setUpViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        self.sut = storyboard.instantiateViewController(withIdentifier: "countrydetailvc") as! CountryDetailViewController
        self.sut.countryPresenter = mockCountryPresenter
        _ = self.sut.view
        
    }

    func testViewDidLoad() {
        sut.viewDidLoad()

        XCTAssertTrue(mockCountryPresenter.loadCountryDetailsCalled)
    }

    func testSaveCountry() {
        sut.saveCountry(self)

        XCTAssertTrue(mockCountryPresenter.saveCountryCalled)
    }

    func testSetCountry() {
        let model = MockCountryModelFactory.getMockedModel()
        model.countryName = "India"

        sut.setCountry(country: model)

        XCTAssertEqual(sut.title, "India")
    }

    func testShowToast() {
        sut.progressHUD = MockProgressHUD.self

        sut.showToast(message: "Hello")

        XCTAssertTrue(MockProgressHUD.showHUDAddedTo)
    }

    func testNumberOfRowsInSection() {
        let numOfrows = sut.tableView(UITableView(), numberOfRowsInSection: 0)

        XCTAssertEqual(numOfrows, 7)
    }

}
