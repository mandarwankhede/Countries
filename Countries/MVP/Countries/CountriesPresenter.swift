//
//  CountriesPresenter.swift
//  Countries
//
//  Created by Mandar Wankhede New on 29/02/20.
//  Copyright © 2020 Mandar Wankhede. All rights reserved.
//

import Foundation

protocol CountriesPresentable {
    var countriesView: CountriesViewable? { get set }
    var networkService: NetworkManager {get set}

    func fetchCountries(by name: String)
}

class CountriesPresenter: CountriesPresentable {
    private var databaseService: DatabaseServiceable
    var networkService: NetworkManager
    weak internal var countriesView: CountriesViewable?

    init(networkService: NetworkManager,  databaseService: DatabaseServiceable) {
        self.networkService = networkService
        self.databaseService = databaseService
    }

    func fetchCountries(by name: String) {
        guard name.isEmpty == false else {
            countriesView?.setEmptyContentView()
            return
        }
        do {
            try networkService.performNetworkTask(endpoint: .searchByCountry(name: name), type: Country.self) { [weak self] resultCountries in
                let mappedCountries = resultCountries.map {
                    CountryModel.fromCountryJsonModel(jsonModel: $0)
                }
                self?.countriesView?.setCountries(countries: mappedCountries)
            }
        } catch let error {
            switch error {
            case NetworkError.noNetwork:
                searchOffline(name: name)
            default:
                print("Unknown Error while calling rest apis")
            }
        }
    }
    
    private func searchOffline(name: String) {
        let resultCountries = databaseService.fetchCountries(by: name)
        countriesView?.setCountries(countries: resultCountries)
    }
}
