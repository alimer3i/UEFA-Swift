//
//  ScreenLoader.swift
//  MVisa
//
//  Created by Ali Merhie on 5/4/20.
//  Copyright © 2020 Monty Mobile. All rights reserved.
//

import Foundation
import UIKit
//import SwiftEntryKit

protocol ScreenLoader {
    
    static func setRootNavigationController() -> Self
    
}

extension ScreenLoader where Self: Storyboarded & UIViewController {
    
    static func setRootNavigationController() -> Self{
        let nextViewController = Self.instantiate() //storyboard.instantiateViewController(withIdentifier: viewController.viewControllerIdentifier)
        
        let nav = RTLNavigationController(rootViewController: nextViewController)
        
        WindowHelper.shared.window.rootViewController = nav
        return nextViewController
    }
    
    static func pushVC(mainView: UIViewController, animated: Bool = true) -> Self{
        let nextViewController = Self.instantiate()
        mainView.navigationController?.pushViewController(nextViewController, animated: animated)
        return nextViewController
    }
    
//    static func popUpFullScreen(mainView: UIViewController, animated: Bool = true) -> Self{
//        let presentedViewController = Self.instantiate()
//        let nav = RTLNavigationController(rootViewController: presentedViewController)
//
//        nav.providesPresentationContextTransitionStyle = true
//        nav.definesPresentationContext = true
//        nav.modalPresentationStyle = UIModalPresentationStyle.overFullScreen;
//        //presentedViewController.view.backgroundColor = UIColor.init(white: 0.4, alpha: 0.8)
//
//        mainView.present(nav, animated: animated, completion: nil)
//        
//        return presentedViewController
//    }
    
        static func getVC() -> Self{
            let nextViewController = Self.instantiate()
            return nextViewController
    
        }
}
