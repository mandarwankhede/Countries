//
//  CountryModel+ExternalTypes.swift
//  Countries
//
//  Created by Mandar Wankhede New on 01/03/20.
//  Copyright © 2020 Mandar Wankhede. All rights reserved.
//

import Foundation

// MARK: - Methods to transform external types to Country Model
extension CountryModel {
    static func fromCountryJsonModel(jsonModel: Country) -> CountryModel {
        let languagesModel = jsonModel.languages.map {
            LanguageModel(name: $0.name ?? "", nativeName: $0.nativeName ?? "")
        }

        return CountryModel(countryName: jsonModel.name,
                            flagUrl: jsonModel.flag,
                            capital: jsonModel.capital,
                            region: jsonModel.region,
                            subRegion: jsonModel.subregion,
                            timezones: jsonModel.timezones,
                            callingCodes: jsonModel.callingCodes,
                            languages: languagesModel)
    }

    static func fromCountryDatabseModel(databaseModel: CountryInfo) -> CountryModel {
        var languagesInfo: [LanguageModel] = []
        if let languages = databaseModel.languages {
            for language in languages {
                if let language = language as? LanguageInfo {
                    let languageModel = LanguageModel(name: language.name ?? "", nativeName: language.nativename ?? "")
                    languagesInfo.append(languageModel)
                }
            }
        }
        return CountryModel(countryName: databaseModel.name ?? "",
                            flagUrl: databaseModel.flagurl ?? "",
                            flag: databaseModel.flag ?? "",
                            capital: databaseModel.capital ?? "",
                            region: databaseModel.region ?? "",
                            subRegion: databaseModel.subregion ?? "",
                            timezones: databaseModel.timezones as? [String] ?? [],
                            callingCodes: databaseModel.callingcodes as? [String] ?? [],
                            languages: languagesInfo)
    }
}
