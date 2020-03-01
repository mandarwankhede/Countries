//
//  CountryPresenterTests.swift
//  CountriesTests
//
//  Created by Mandar Wankhede New on 02/03/20.
//  Copyright © 2020 Mandar Wankhede. All rights reserved.
//

import XCTest
@testable import Countries

class CountryPresenterTests: XCTestCase {
    var mockCountryModel: CountryModel!
    var mockDatabaseService: MockDatabaseService!
    var mockCountryView: MockCountryView!
    var sut:CountryPresenter!

    override func setUp() {
        mockCountryModel = MockCountryModelFactory.getMockedModel()
        mockDatabaseService = MockDatabaseService()
        mockCountryView = MockCountryView()
        sut = CountryPresenter(countryModel: mockCountryModel, databaseService: mockDatabaseService)
        sut.countriesView = mockCountryView
    }

    override func tearDown() {
        mockCountryModel = nil
        mockDatabaseService = nil
        mockCountryView = nil
        sut = nil
    }

    func testLoadCountryDetails() {
        sut.loadCountryDetails()

        XCTAssertTrue(mockCountryView.setCountryCalled)
    }

    func testSaveCountry() {
        sut.saveCountry()

        XCTAssertTrue(mockDatabaseService.saveCountryCalled)
    }
}
