//
//  StringExtension.swift
//  PalmReading
//
//  Created by Ali Merhie on 9/13/19.
//  Copyright © 2019 Monty Mobile. All rights reserved.
//

import Foundation
import UIKit
import ObjectMapper

protocol Localizable {
    var tableName: String { get }
    var localized: String { get }
    func localizedWithParameters(_ parameters: CVarArg...) -> String
}


enum LanguageEnum: CaseIterable {
    case english
    case French

    var instance: LanguageModel {
        switch self {
        case .english: return LanguageModel(id:"en", title: "English", isRTL: false, iconName: "GB")
        case .French: return LanguageModel(id:"fr", title: "Français", isRTL: false, iconName: "FR")
        }
    }
}

extension Localizable where Self: RawRepresentable, Self.RawValue == String {
    var localized: String {
        return rawValue.localizedText(tableName: tableName)
    }
}

extension String {
    
    func localizedText(bundle: Bundle = Bundle(path: Bundle.main.path(forResource: SelectedLanguageDefualt.id, ofType: "lproj")!)!, tableName: String = "Localizable") -> String {
        return NSLocalizedString(self, tableName: tableName, bundle: bundle, value: "**\(self)**", comment: "")
    }
    
    func localizedWithParameters(_ parameters: CVarArg...) -> String {
        return String(format: self.localizedText(), arguments: parameters)
    }
}


class LanguageModel: Mappable, Codable {
    
    var id: String!
    var title: String!
    var isRTL: Bool! 
    var iconName: String!

    init(id: String, title: String, isRTL: Bool, iconName: String) {
        self.id = id
        self.title = title
        self.isRTL = isRTL
        self.iconName = iconName

    }
    required init?(map: Map) {
        id <- map["id"]
        title <- map["title"]
        isRTL <- map["isRTL"]
        
    }
    
    func mapping(map: Map) {
        
    }
}
