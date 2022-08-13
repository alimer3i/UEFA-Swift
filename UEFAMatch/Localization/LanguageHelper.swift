//
//  LanguageHelper.swift
//  PalmReading
//
//  Created by Ali Merhie on 9/20/19.
//  Copyright © 2019 Monty Mobile. All rights reserved.
//

import Foundation
import UIKit

class LanguageHelper {
    
    public static func changeLanguage(languageEnum: LanguageEnum) {
        let selectedLang = languageEnum.instance
        changeLanguage(language: selectedLang)

        //Shared.navigateWithNavigationBar(viewController: TabBar_VC)
        //NotificationCenter.default.post(name: NSNotification.Name(rawValue: LANGUAGE_CHANGED_OBSERVER), object: nil)
       // Shared.navigateWithNavigationBar(viewController: Root_VC)
        
    }
    public static func changeLanguage(language: LanguageModel) {
        let isRTL = language.isRTL! //language.id == Language.arabic.instance.id ? true : false
        currentLanguageIsRTL = isRTL
        UIView.appearance().semanticContentAttribute = isRTL ? .forceRightToLeft : .forceLeftToRight
        SelectedLanguageDefualt = language

    }
    
}
