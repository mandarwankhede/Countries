//
//  MockCountriesPresenter.swift
//  CountriesTests
//
//  Created by Mandar Wankhede New on 02/03/20.
//  Copyright © 2020 Mandar Wankhede. All rights reserved.
//

import Foundation
@testable import Countries

class MockCountriesPresenter: CountriesPresentable {
    var countriesView: CountriesViewable?
    var networkService: NetworkManager
    var fetchCountriesCalled = false
    
    init(countriesView: CountriesViewable, networkService: NetworkManager) {
        self.countriesView = countriesView
        self.networkService = networkService
    }
    
    func fetchCountries(by name: String) {
        fetchCountriesCalled = true
    }
}
