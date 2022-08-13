//
//  NsLocaleExtension.swift
//  SelfCare
//
//  Created by Ali Merhie on 11/7/19.
//  Copyright © 2019 Monty Mobile. All rights reserved.
//

import Foundation

extension NSLocale {

    struct Locale {
        let countryCode: String
        let countryName: String
    }

    class func getCountries() -> [Locale] {
        var locales = [Locale]()

         NSLocale.isoCountryCodes.map { (code:String)  in
            let countryCode = code
            let id = NSLocale.localeIdentifier(fromComponents: [NSLocale.Key.countryCode.rawValue: code])
            let countryName = NSLocale(localeIdentifier: "en_US").displayName(forKey: NSLocale.Key.identifier, value: id) ?? "Country not found for code: \(code)"
            let locale = Locale(countryCode: countryCode, countryName: countryName)
            locales.append(locale)

         }
        return locales
    }

}
