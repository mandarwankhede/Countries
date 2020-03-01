//
//  MockDatabaseService.swift
//  CountriesTests
//
//  Created by Mandar Wankhede New on 02/03/20.
//  Copyright © 2020 Mandar Wankhede. All rights reserved.
//

@testable import Countries

class MockDatabaseService: DatabaseServiceable {
    var saveCountryCalled = false
    var fetchCountriesCalled = false
    
    func saveCountry(country: CountryModel, completion: (Error?) -> ()) {
        saveCountryCalled = true
    }
    
    func fetchCountries(by name: String) -> [CountryModel] {
        fetchCountriesCalled = true
        return []
    }
}
