//
//  AppUpdateChecker.swift
//  VirtualNumber
//
//  Created by Joe Maghzal on 25/05/2022.
//

import UIKit

class AppUpdateChecker {
    static func startCheck() {
        AppUpdateHelper.shared.fetchCloudValues {
            guard AppUpdateHelper.shared.isOutdated && (!AppSettings.ignoresUpdates || AppUpdateHelper.shared.forceUpdate)  else {return}
            DispatchQueue.main.async {
                _ = UpdateViewController.popUpFullScreen(mainView: UIApplication.getTopViewController()!)
            }
        }
    }
}
