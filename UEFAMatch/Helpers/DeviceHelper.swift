//
//  DeviceHelper.swift
//  CallerRate
//
//  Created by Ali Merhie on 12/12/19.
//  Copyright © 2019 Monty Mobile. All rights reserved.
//

import Foundation
import FCUUID
import GBDeviceInfo
import CoreTelephony
import UIKit

class DeviceHelper {
    static let networkInfo =  CTTelephonyNetworkInfo()

    public static var deviceUniqueId: String {
        return FCUUID.uuidForDevice()
    }
    public static var appVersion: String {
        return  (Bundle.main.infoDictionary?["CFBundleShortVersionString"] ?? "") as! String
        
    }
    public static var appVersionDisplay: String {
        return "Version \(DeviceHelper.appVersion )(\(DeviceHelper.appBuildNumber ?? "")) \((Environment.config == .debug) ? "(α)" : "")"
    }
    public static var appBuildNumber: String {
        return  (Bundle.main.infoDictionary?["CFBundleVersion"] ?? "") as! String
    }
    public static var model: String {
        return UIDevice.current.model
    }
    public static var localizedModel: String {
        return UIDevice.current.localizedModel
    }
    public static var systemName: String {
        return UIDevice.current.systemName
    }
    public static var systemVersion: String {
        return UIDevice.current.systemVersion
    }
    public static var name: String {
        return UIDevice.current.name
    }
    public static var modelString: String {
        return GBDeviceInfo.deviceInfo()?.modelString ?? ""
    }
    public static var systemInfo: String {
        return GBDeviceInfo.deviceInfo()?.rawSystemInfoString ?? ""
    }
    public static var mobileCountryCode: String {
        let carrier = networkInfo.subscriberCellularProvider
        return carrier?.mobileCountryCode ?? ""
    }
    public static var mobileNetworkCode: String {
        let carrier = networkInfo.subscriberCellularProvider
        return carrier?.mobileNetworkCode ?? ""
    }
    public static var CarrierName: String {
        let carrier = networkInfo.subscriberCellularProvider
        return carrier?.carrierName ?? ""
    }
}

