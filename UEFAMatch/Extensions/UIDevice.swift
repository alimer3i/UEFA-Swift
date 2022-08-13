//
//  UIDevice.swift
//  VirtualNumber
//
//  Created by Joe Maghzal on 24/05/2022.
//

import UIKit

extension UIDevice {
    var isJailBroken: Bool {
        #if targetEnvironment(simulator)
        return false
        #else
        return FileManager.default.fileExists(atPath: "/Applications/Cydia.app")
            || FileManager.default.fileExists(atPath: "/Library/MobileSubstrate/MobileSubstrate.dylib")
            || FileManager.default.fileExists(atPath: "/bin/bash")
            || FileManager.default.fileExists(atPath: "/usr/sbin/sshd")
            || FileManager.default.fileExists(atPath: "/etc/apt")
            || FileManager.default.fileExists(atPath: "/private/var/lib/apt/")
            || FileManager.default.fileExists(atPath: "/Library/MobileSubstrate/MobileSubstrate.dylib")
            || FileManager.default.fileExists(atPath: "/private/var/stash")
            || FileManager.default.fileExists(atPath: "/private/var/lib/apt")
            || FileManager.default.fileExists(atPath: "/private/var/tmp/cydia.log")
            || FileManager.default.fileExists(atPath: "/private/var/mobile/Library/SBSettings/Themes")
        #endif
    }
}
