//
//  CountryPresenter.swift
//  Countries
//
//  Created by Mandar Wankhede New on 01/03/20.
//  Copyright © 2020 Mandar Wankhede. All rights reserved.
//

import Foundation

protocol CountryPresentable {
    func loadCountryDetails()
    func saveCountry()
}

class CountryPresenter: CountryPresentable {
    private var countryModel: CountryModel?
    private var databaseService: DatabaseServiceable
    weak internal var countriesView: CountryViewable?

    init(countryModel: CountryModel?, databaseService: DatabaseServiceable) {
        self.countryModel = countryModel
        self.databaseService = databaseService
    }

    func loadCountryDetails() {
        if let countryModel = countryModel {
            countriesView?.setCountry(country: countryModel)
        }
    }

    func saveCountry() {
        if let model = countryModel {
            databaseService.saveCountry(country: model) { error in
                if let _ = error {
                    // Log the error and show toast
                    countriesView?.showToast(message: "Failed to save")
                    return
                }
                countriesView?.showToast(message: "Saved successfully..")
            }
        }
    }
}
