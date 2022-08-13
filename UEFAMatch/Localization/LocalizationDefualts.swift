//
//  LocalizationDefualts.swift
//  CoronaCare
//
//  Created by Ali Merhie on 4/10/20.
//  Copyright © 2020 Monty Mobile. All rights reserved.
//

import Foundation
import  ObjectMapper

var currentLanguageIsRTL: Bool {
    set {
        UserDefaults.standard.set(newValue, forKey: "IsCurrenLanguageRTL")
    }
    get {
        return UserDefaults.standard.bool(forKey: "IsCurrenLanguageRTL") ?? false
    }
}
var SelectedLanguageDefualt: LanguageModel {
    set {
        let userJson = try! JSONEncoder().encode(newValue)
        let jsonString = String(data: userJson, encoding: .utf8)!
        UserDefaults.standard.set(jsonString, forKey: "SelectedLanguage")
    }
    get {
        if let userJosn = UserDefaults.standard.string(forKey: "SelectedLanguage"){
        let userData = Mapper<LanguageModel>().map(JSONString: userJosn)!
        return userData
        }else{
            return LanguageEnum.French.instance
        }
    }
}
