//
//  AppSettings.swift
//  VirtualNumber
//
//  Created by Ali Merhie on 9/21/21.
//

import UIKit
import SwiftKeychainWrapper
import  ObjectMapper

struct AppSettings {
    static var lastReceivedVersion: String {
        set {
            UserDefaults.standard.set(newValue, forKey: "LastReceivedVersion")
            UserDefaults.standard.synchronize()
        }
        get {
            let lastReceivedVersion = UserDefaults.standard.string(forKey: "LastReceivedVersion") ?? ""
            return lastReceivedVersion
        }
    }
    static var appStoreId: String? {
        set {
            guard let newValue = newValue else {return}
            UserDefaults.standard.set(newValue, forKey: "AppStoreID")
            UserDefaults.standard.synchronize()
        }
        get {
            let appStoreId = UserDefaults.standard.string(forKey: "AppStoreID")
            return appStoreId
        }
    }
    static var ignoresUpdates: Bool {
        set {
            UserDefaults.standard.set(newValue, forKey: "IgnoresUpdates")
            UserDefaults.standard.synchronize()
        }
        get {
            let ignoresUpdates = UserDefaults.standard.object(forKey: "IgnoresUpdates") as? Bool ?? false
            return ignoresUpdates
        }
    }
    static var isAppleTesting : Bool {
        set {
            UserDefaults.standard.set(newValue, forKey: "isAppleTesting")
            UserDefaults.standard.synchronize()
        }
        get {
            let isAppleTesting = UserDefaults.standard.bool(forKey: "isAppleTesting")
            return isAppleTesting
        }
    }
    
    static var isLoggedIn:Bool{
        get{
            let isLoggedin = UserDefaults.standard.bool(forKey: "isLoggedIn")
            return isLoggedin
        }
        set{
            UserDefaults.standard.set(newValue, forKey: "isLoggedIn")
            UserDefaults.standard.synchronize()
        }
    }

    static var token : String {
        set {
            KeychainWrapper.standard.set(newValue, forKey: "token")
        }
        get {
            let token = KeychainWrapper.standard.string(forKey: "token") ?? ""
            return token
        }
    }
    
    static var refreshtoken : String {
        set {
            KeychainWrapper.standard.set(newValue, forKey: "refreshtoken")
        }
        get {
            let token = KeychainWrapper.standard.string(forKey: "refreshtoken") ?? ""
            return token
        }
    }
    
    //    static var currentAppLanguage:AppLanguage{
    //          get{
    //            let currentAppLang = UserDefaults.standard.string(forKey: "currentAppLanuage")  ?? "id"
    //            return AppLanguage(rawValue: currentAppLang)!
    //          }
    //          set{
    //            UserDefaults.standard.set(newValue.rawValue, forKey: "currentAppLanuage")
    //              UserDefaults.standard.synchronize()
    //          }
    //      }
}
