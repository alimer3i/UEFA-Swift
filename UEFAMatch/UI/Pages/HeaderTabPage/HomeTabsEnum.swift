//
//  HomeTabsEnum.swift
//  UEFAMatch
//
//  Created by Ali Merhie on 8/13/22.
//

import Foundation

enum HomeTabsEnum: Int {
    case overview = 1
    case matches = 2
    case groups = 3
    case stats = 4
    case squad = 5
    
    func gertitle() -> String{
        switch self {
        case .overview:
            return "Overview"
        case .matches:
            return "Matches"
        case .groups:
            return "Groups"
        case .stats:
            return "Stats"
        case .squad:
            return "Squad"
        }
    }
}
