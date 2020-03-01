//
//  MockCountryView.swift
//  CountriesTests
//
//  Created by Mandar Wankhede New on 02/03/20.
//  Copyright © 2020 Mandar Wankhede. All rights reserved.
//

@testable import Countries

class MockCountryView: CountryViewable {
    var setCountryCalled = false
    var showToastCalled = false

    func setCountry(country: CountryModel) {
        setCountryCalled = true
    }
    
    func showToast(message: String) {
        showToastCalled = true
    }
}
