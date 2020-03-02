//
//  CountriesTableViewControllerTests.swift
//  CountriesTests
//
//  Created by Mandar Wankhede New on 02/03/20.
//  Copyright © 2020 Mandar Wankhede. All rights reserved.
//

import XCTest
@testable import Countries

class CountriesTableViewControllerTests: XCTestCase {
    var mockCountriesPresenter: MockCountriesPresenter!
    var sut: CountriesTableViewController!
    
    override func setUp() {
        mockCountriesPresenter = MockCountriesPresenter(countriesView: MockCountriesView(), networkService: MockNetworkManager())
        setUpViewControllers()
    }
    
    private func setUpViewControllers() {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        self.sut = storyboard.instantiateViewController(withIdentifier: "countriesvc") as! CountriesTableViewController
        self.sut.countriesPresenter = mockCountriesPresenter
        _ = self.sut.view
        
    }

    override func tearDown() {
        mockCountriesPresenter = nil
        sut = nil
    }

    func testViewDidLoad() {
        sut.viewDidLoad()

        XCTAssertNotNil(mockCountriesPresenter.countriesView)
        XCTAssertTrue(mockCountriesPresenter.countriesView is CountriesTableViewController)
    }

    func testSetCountries() {
        let mockCountries = [MockCountryModelFactory.getMockedModel()]
        sut.setCountries(countries: mockCountries)

        XCTAssertEqual(mockCountries.count, sut.countriesToDisplay.count)
    }
    
    func testEmptyCountries() {
        sut.setEmptyContentView()

        XCTAssertEqual(sut.countriesToDisplay.count, 0)
    }
}
