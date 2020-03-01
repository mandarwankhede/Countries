//
//  MockCountryModelFactory.swift
//  CountriesTests
//
//  Created by Mandar Wankhede New on 02/03/20.
//  Copyright © 2020 Mandar Wankhede. All rights reserved.
//

@testable import Countries

class MockCountryModelFactory {
    class func getMockedModel() -> CountryModel {
        CountryModel(countryName: "name",
                     flagUrl: "flag.com",
                     capital: "capital",
                     region: "region",
                     subRegion: "subregion",
                     timezones: [],
                     callingCodes: [],
                     languages: [])
    }
}
