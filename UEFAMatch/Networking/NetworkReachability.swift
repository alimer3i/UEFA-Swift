//
//  NetworkReachability.swift
//  RBT
//
//  Created by Ali Merhie on 22/07/2021.
//

import UIKit
import Alamofire

class NetworkReachability {
    
    static let shared = NetworkReachability()
    static var isReachable = false
    
    var currentVc: UIViewController?
    
    let offlineAlertController: UIAlertController = {
        UIAlertController(title: "No Network", message: "Please connect to network and try again", preferredStyle: .alert)
    }()
    
    func showOfflineAlert() {
        NetworkReachability.isReachable = false
        NotificationCenter.default.post(name: .internetConnectionLost, object: nil)
        
        currentVc = UIApplication.getTopViewController()
        currentVc?.present(offlineAlertController, animated: true, completion: nil)
    }
    
    func dismissOfflineAlert() {
        NetworkReachability.isReachable = true
        NotificationCenter.default.post(name: .internetConnectionBack, object: nil)
        if let strongVc = currentVc {
            strongVc.dismiss(animated: true, completion: nil)
        }
    }
    
    let reachabilityManager = NetworkReachabilityManager(host: "www.google.com")
    
    func startNetworkMonitoring() {
        reachabilityManager?.startListening { status in
            switch status {
            case .notReachable:
                self.showOfflineAlert()
            case .reachable(.cellular):
                self.dismissOfflineAlert()
            case .reachable(.ethernetOrWiFi):
                self.dismissOfflineAlert()
            case .unknown:
                self.showOfflineAlert()
                print("Unknown network state")
            }
        }
    }
}

