//
//  Country.swift
//  Countries
//
//  Created by Mandar Wankhede on 29/02/20.
//  Copyright © 2019 Maddy. All rights reserved.
//

import Foundation

// MARK: - Country
struct Country: Codable {
    let name: String
    let topLevelDomain: [String]
    let alpha2Code, alpha3Code: String
    let callingCodes: [String]
    let capital: String
    let altSpellings: [String]
    let region, subregion: String
    let population: Int?
    let latlng: [Double]
    let demonym: String?
    let area: Double?
    let gini: Double?
    let timezones, borders: [String]
    let nativeName, numericCode: String?
    let currencies: [Currency]
    let languages: [Language]
    let translations: Translations
    let flag: String
    let regionalBlocs: [RegionalBloc]
    let cioc: String?
}

// MARK: - Currency
struct Currency: Codable {
    let code, name, symbol: String?
}

// MARK: - Language
struct Language: Codable {
    let iso6391, iso6392, name, nativeName: String

    enum CodingKeys: String, CodingKey {
        case iso6391 = "iso639_1"
        case iso6392 = "iso639_2"
        case name, nativeName
    }
}

// MARK: - RegionalBloc
struct RegionalBloc: Codable {
    let acronym, name: String
    let otherAcronyms, otherNames: [String]
}

// MARK: - Translations
struct Translations: Codable {
    let de: String?
    let es: String?
    let fr: String?
    let ja: String?
    let it, br, pt: String?
    let nl, hr: String?
    let fa: String?
}
