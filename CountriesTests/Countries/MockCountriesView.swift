//
//  MockCountriesView.swift
//  CountriesTests
//
//  Created by Mandar Wankhede New on 02/03/20.
//  Copyright © 2020 Mandar Wankhede. All rights reserved.
//

@testable import Countries

class MockCountriesView: CountriesViewable {
    var setCountriesCalled = false
    var setEmptyContentViewCalled = false
    
    func setCountries(countries: [CountryModel]) {
        setCountriesCalled = true
    }
    
    func setEmptyContentView() {
        setEmptyContentViewCalled = true
    }
}
