//
//  CoreDataService.swift
//  Countries
//
//  Created by Mandar Wankhede New on 01/03/20.
//  Copyright © 2020 Mandar Wankhede. All rights reserved.
//

import UIKit
import CoreData

fileprivate struct TablesNames{
    static let country = "CountryInfo"
    static let language = "LanguageInfo"
}

enum DatabaseError: Error {
    case failedToSave(String)
    case invalidConfiguration(String)
}

class CoreDataService: DatabaseServiceable {
    var appDelegate: AppDelegate? {
        UIApplication.shared.delegate as? AppDelegate
    }
    var managedContext: NSManagedObjectContext? {
        appDelegate?.persistentContainer.viewContext
    }
    
    func saveCountry(country: CountryModel, completion: (Error?) -> ()) {
        guard let context = managedContext else {
                completion(DatabaseError.invalidConfiguration("Database configuration is not set correctly"))
            return
        }
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        
        let countryInfo = CountryInfo(context: context)
        countryInfo.name = country.countryName
        countryInfo.capital = country.capital
        countryInfo.region = country.region
        countryInfo.subregion = country.subRegion
        countryInfo.flag = country.flag
        countryInfo.flagurl = country.flagUrl
        countryInfo.callingcodes = country.callingCodes as NSObject
        
        let languages = country.languages.map { model -> LanguageInfo in
            let languageInfo = LanguageInfo(context: context)
            languageInfo.name = model.name
            languageInfo.nativename = model.nativeName
            return languageInfo
        }
        countryInfo.setValue(NSSet.init(array: languages), forKey: "languages")
        
        save(completion: completion)
    }
    
    func fetchCountries(by name: String) -> [CountryModel] {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: TablesNames.country)
        fetchRequest.predicate = NSPredicate(format: "name contains[c] %@", name)
        do {
            if let countriesInfo = try managedContext?.fetch(fetchRequest) as? [CountryInfo] {
                let result = countriesInfo.map {
                    CountryModel.fromCountryDatabseModel(databaseModel: $0)
                }
                return result
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return []
        }
        return []
    }
    
    private func save(completion: (Error?) -> ()) {
        do {
            try managedContext?.save()
            completion(nil)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
            completion(DatabaseError.failedToSave(error.localizedDescription))
        }
    }
}
