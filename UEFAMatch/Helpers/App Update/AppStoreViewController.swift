//
//  AppStoreViewController.swift
//  VirtualNumber
//
//  Created by Joe Maghzal on 25/05/2022.
//

import UIKit
import StoreKit

class AppStore: NSObject, SKStoreProductViewControllerDelegate {
    static var shared = AppStore()
    func openAppInAppStore(_ viewController: UIViewController) {
        guard let id = AppSettings.appStoreId else {
            AppUpdateHelper.shared.fetchAppStoreId {
                AppStore.shared.openAppInAppStore(viewController)
            }
            return
        }
        let storeViewController = SKStoreProductViewController()
        storeViewController.delegate = self
        let parameters = [SKStoreProductParameterITunesItemIdentifier: id]
        storeViewController.loadProduct(withParameters: parameters) { loaded, error in
            guard loaded else {return}
            DispatchQueue.main.async {
                viewController.present(storeViewController, animated: true)
            }
        }
    }
    private func productViewControllerDidFinish(viewController: SKStoreProductViewController) {
        DispatchQueue.main.async {
            viewController.dismiss(animated: true, completion: nil)
        }
    }
}
