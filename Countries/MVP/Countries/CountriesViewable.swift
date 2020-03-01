//
//  CountriesViewable.swift
//  Countries
//
//  Created by Mandar Wankhede New on 29/02/20.
//  Copyright © 2020 Mandar Wankhede. All rights reserved.
//

import UIKit
import WebKit

protocol CountriesViewable: class {
    func setCountries(countries: [CountryModel])
    func setEmptyContentView()
}
