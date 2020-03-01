//
//  CountryModel.swift
//  Countries
//
//  Created by Mandar Wankhede New on 29/02/20.
//  Copyright © 2020 Mandar Wankhede. All rights reserved.
//

import Foundation

class CountryModel: NSObject {
    var countryName: String
    var flagUrl: String
    var capital: String
    var region: String
    var subRegion: String
    var timezones: [String]
    var callingCodes: [String]
    var languages: [LanguageModel]
    @objc dynamic var flag: String?
    private var queue: DispatchQueue

    init(countryName: String,
         flagUrl: String,
         flag: String = "",
         capital: String,
         region: String,
         subRegion: String,
         timezones: [String],
         callingCodes: [String],
         languages: [LanguageModel],
         queue: DispatchQueue = .global()) {
        self.countryName = countryName
        self.flagUrl = flagUrl
        self.flag = flag
        self.capital = capital
        self.region = region
        self.subRegion = subRegion
        self.timezones = timezones
        self.callingCodes = callingCodes
        self.languages = languages
        self.queue = queue
        super.init()

        if flag.isEmpty == true {
            fetchFlagImage()
        }
    }
}

extension CountryModel {
    private func fetchFlagImage() {
        guard let url = URL(string: flagUrl) else { return }
        queue.async {
            if let svString = try? String(contentsOf: url) {
                self.flag = svString
            }
        }
    }
}
