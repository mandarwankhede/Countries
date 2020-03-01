//
//  CountryViewable.swift
//  Countries
//
//  Created by Mandar Wankhede New on 29/02/20.
//  Copyright © 2020 Mandar Wankhede. All rights reserved.
//

import Foundation

protocol CountryViewable: class {
    func setCountry(country: CountryModel)
    func showToast(message: String)
}
