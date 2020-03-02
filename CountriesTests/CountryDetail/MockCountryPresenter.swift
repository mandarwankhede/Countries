//
//  MockCountryPresenter.swift
//  CountriesTests
//
//  Created by Mandar Wankhede New on 02/03/20.
//  Copyright © 2020 Mandar Wankhede. All rights reserved.
//

import Foundation
@testable import Countries

class MockCountryPresenter: CountryPresentable {
    var loadCountryDetailsCalled = false
    var saveCountryCalled = true

    func loadCountryDetails() {
        loadCountryDetailsCalled = true
    }
    
    func saveCountry() {
        saveCountryCalled = true
    }
}
