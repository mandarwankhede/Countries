//
//  CountriesPresenterTests.swift
//  CountriesTests
//
//  Created by Mandar Wankhede New on 02/03/20.
//  Copyright © 2020 Mandar Wankhede. All rights reserved.
//

import XCTest
@testable import Countries

class CountriesPresenterTests: XCTestCase {
    var sut: CountriesPresenter!
    var mockNetworkManager: MockNetworkManager!
    var mockDatabaseService: MockDatabaseService!
    var mockCountriesView: MockCountriesView!
    var mockReachability: MockReachability.Type!
    
    override func setUp() {
        mockReachability = MockReachability.self
        mockNetworkManager = MockNetworkManager(reachability: mockReachability)
        mockDatabaseService = MockDatabaseService()
        mockCountriesView = MockCountriesView()
        sut = CountriesPresenter(networkService: mockNetworkManager, databaseService: mockDatabaseService)
        sut.countriesView = mockCountriesView
    }

    override func tearDown() {
        mockReachability = nil
        mockNetworkManager = nil
        mockDatabaseService = nil
        mockCountriesView = nil
        sut = nil
    }

    func testFetchCountries_EmptyName() {
        sut.fetchCountries(by: "")

        XCTAssertTrue(mockCountriesView.setEmptyContentViewCalled)
        XCTAssertFalse(mockNetworkManager.performNetworkTaskCalled)
    }

    func testFetchCountries_NonEmptyName() {
        sut.fetchCountries(by: "Foo")

        XCTAssertFalse(mockCountriesView.setEmptyContentViewCalled)
        XCTAssertTrue(mockNetworkManager.performNetworkTaskCalled)
    }
    
    func testSearchOffline() {
        mockReachability.isConnected = false
        sut = CountriesPresenter(networkService: NetworkManager(reachability: mockReachability), databaseService: mockDatabaseService)
        sut.countriesView = mockCountriesView

        sut.fetchCountries(by: "foo")
        
        XCTAssertTrue(mockDatabaseService.fetchCountriesCalled)
        XCTAssertTrue(mockCountriesView.setCountriesCalled)
    }
}
