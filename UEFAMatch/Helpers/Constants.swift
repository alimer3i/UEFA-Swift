//
//  Constants.swift
//  VirtualNumber
//
//  Created by Ali Merhie on 9/27/21.
//

import Foundation
struct Constant {
    
}
enum SilentPushActionEnum: Int {
    case SubsriptionUpdated = 0
}

enum Environment: String {
    static var config: Environment {
    #if DEBUG_MODE
        return Environment.debug
    #else
        return Environment.release
    #endif
    }
    case release = "Release"
    case debug = "Debug"

    static var url: String {
        switch Environment.config {
        case .release:
            return "https://vna.montymobile.com"
        case .debug:
            return "https://vna-test.montymobile.com"
        }
    }
}
