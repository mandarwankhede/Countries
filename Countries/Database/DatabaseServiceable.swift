//
//  DatabaseServiceable.swift
//  Countries
//
//  Created by Mandar Wankhede New on 01/03/20.
//  Copyright © 2020 Mandar Wankhede. All rights reserved.
//

protocol DatabaseServiceable {
    func saveCountry(country: CountryModel, completion: (Error?) -> ())
    func fetchCountries(by name: String) -> [CountryModel]
}
