//
//  CountriesAPIs.swift
//  Countries
//
//  Created by Mandar Wankhede on 29/02/20.
//  Copyright © 2019 Maddy. All rights reserved.
//

import Foundation

protocol EndpointType {
    var baseURL: URL { get }
    var path: String { get }
    
}

enum CountriesAPI {
    case allCountries
    case searchByCountry(name: String)
}

extension CountriesAPI: EndpointType {
    var baseURL: URL {
        return URL(string: "https://restcountries.eu/rest/v2")!
    }
    
    var path: String {
        switch self {
        case .allCountries:
            return "/all"
        case .searchByCountry(let name):
            return "/name/\(name)"
        }
    }
}
