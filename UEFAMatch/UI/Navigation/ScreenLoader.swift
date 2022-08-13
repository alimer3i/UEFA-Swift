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
import PanModal

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
    
    static func popUpFullScreen(mainView: UIViewController, animated: Bool = true) -> Self{
        let presentedViewController = Self.instantiate()
        let nav = RTLNavigationController(rootViewController: presentedViewController)

        nav.providesPresentationContextTransitionStyle = true
        nav.definesPresentationContext = true
        nav.modalPresentationStyle = UIModalPresentationStyle.overFullScreen;
        //presentedViewController.view.backgroundColor = UIColor.init(white: 0.4, alpha: 0.8)

        mainView.present(nav, animated: animated, completion: nil)
        
        return presentedViewController
    }
    
        static func getVC() -> Self{
            let nextViewController = Self.instantiate()
            return nextViewController
    
        }
}

//class ScreenLoader1  {
//    
//    public func setRootNavigationController(viewController: ViewControllerModel){
//        let storyboard = UIStoryboard(name: viewController.storyBoardIdentifier, bundle: nil)
//        let nextViewController = storyboard.instantiateViewController(withIdentifier: viewController.viewControllerIdentifier)
//        //add setting button to navigation
//        //        if viewController != Login_VC && viewController != Register_VC && viewController != Verify_VC {
//        //            let buttonSetting = UIBarButtonItem(image: UIImage(named: "settings"), style: .plain, target: self, action: #selector(self.openSetting))
//        //            buttonSetting.tintColor = UIColor.white
//        //            nextViewController.navigationItem.rightBarButtonItem  = buttonSetting
//        //        }
//
//        let nav = RTLNavigationController(rootViewController: nextViewController)
//
//        WindowHelper.shared.window.rootViewController = nav
//    }
//    
//    public func getVC(viewController: ViewControllerModel) -> UIViewController{
//        let storyboard = UIStoryboard(name: viewController.storyBoardIdentifier, bundle: nil)
//        let nextViewController = (storyboard.instantiateViewController(withIdentifier: viewController.viewControllerIdentifier))        
//        return nextViewController
//        
//    }
//    
//    public func pushVC(rootView: UIViewController, viewController: ViewControllerModel, animated: Bool = true) -> UIViewController{
//        let storyboard = UIStoryboard(name: viewController.storyBoardIdentifier, bundle: nil)
//        let nextViewController = (storyboard.instantiateViewController(withIdentifier: viewController.viewControllerIdentifier))
//        rootView.navigationController?.pushViewController(nextViewController, animated: animated)
//        
//        return nextViewController
//        
//    }
//    public func popUpView(mainView: UIViewController, popUpVc: ViewControllerModel) -> UIViewController{
//        let storyboard = UIStoryboard(name: popUpVc.storyBoardIdentifier, bundle: nil)
//        let presentedViewController = storyboard.instantiateViewController(withIdentifier: popUpVc.viewControllerIdentifier)
//        presentedViewController.providesPresentationContextTransitionStyle = true
//        presentedViewController.definesPresentationContext = true
//        presentedViewController.modalPresentationStyle = UIModalPresentationStyle.overFullScreen;
//        //presentedViewController.view.backgroundColor = UIColor.init(white: 0.4, alpha: 0.8)
//        mainView.present(presentedViewController, animated: true, completion: nil)
//        
//        return presentedViewController
//    }
////    public func popUpHalfView(mainView: UIViewController, popUpVc: ViewControllerModel, height: CGFloat = UIScreen.main.bounds.height/1.5) -> UIViewController{
////        let storyboard = UIStoryboard(name: popUpVc.storyBoardIdentifier, bundle: nil)
////        let presentedViewController = storyboard.instantiateViewController(withIdentifier: popUpVc.viewControllerIdentifier)
////        let options = [
////            SemiModalOption.pushParentBack: false,
////        ]
////        //presentedViewController.view.backgroundColor = UIColor.red
////        presentedViewController.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: height)
////
////        mainView.presentSemiViewController(presentedViewController, options: options, completion: {
////            print("Completed!")
////        }, dismissBlock: {
////            print("Dismissed!")
////        })
////        return presentedViewController
////    }
//    public func popUpPanModel(mainView: UIViewController, viewController: ViewControllerModel) -> UIViewController & PanModalPresentable{
//        let storyboard = UIStoryboard(name: viewController.storyBoardIdentifier, bundle: nil)
//        let nextViewController = storyboard.instantiateViewController(withIdentifier: viewController.viewControllerIdentifier) as! UIViewController & PanModalPresentable
//        mainView.presentPanModal(nextViewController)
//        return nextViewController
//    }
//    public func presentFullScreen(mainView: UIViewController, viewController: ViewControllerModel, animated: Bool = true) -> UIViewController{
//        let storyboard = UIStoryboard(name: viewController.storyBoardIdentifier, bundle: nil)
//        let nextViewController = storyboard.instantiateViewController(withIdentifier: viewController.viewControllerIdentifier) as! UIViewController
//        let nav = RTLNavigationController(rootViewController: nextViewController)
//        nav.modalPresentationStyle = .overFullScreen
//
//        mainView.present(nav, animated: animated) {
//            
//        }
//        return nav
//    }
//    
////    public func popUpAdvancedView(mainView: UIViewController, popUpVc: ViewControllerModel) -> UIViewController{
////        let storyboard = UIStoryboard(name: popUpVc.storyBoardIdentifier, bundle: nil)
////        let presentedViewController = storyboard.instantiateViewController(withIdentifier: popUpVc.viewControllerIdentifier)
////        
////        // Create a basic toast that appears at the top
////        var attributes = EKAttributes.topToast
////        // Set its background to white
////        attributes.entryBackground = .color(color: .black)
////        attributes.displayDuration = .infinity
////        // Animate in and out using default translation
////        attributes.entranceAnimation = .translation
////        attributes.exitAnimation = .translation
////        attributes.border = .none
////        //attributes.position = .center
////        //attributes.screenInteraction = .forward
////        attributes.precedence.priority = .high
////        attributes.entryInteraction = .absorbTouches
////        // Give the entry the width of the screen minus 20pts from each side, the height is decided by the content's contraint's
////        // attributes.positionConstraints.size = .init(width: .offset(value: 20), height: .intrinsic)
////        
////        // Give the entry maximum width of the screen minimum edge - thus the entry won't grow much when the device orientation changes from portrait to landscape mode.
////        //let edgeWidth = min(UIScreen.main.bounds.width, UIScreen.main.bounds.height)
////        //attributes.positionConstraints.maxSize = .init(width: .constant(value: edgeWidth), height: screenHeight)
////        attributes.positionConstraints.size = .init(width: .constant(value: screenWidth), height: .constant(value: screenHeight))
////        
////        if SwiftEntryKit.isCurrentlyDisplaying {
////            SwiftEntryKit.dismiss()
////        }else{
////            SwiftEntryKit.display(entry: presentedViewController, using: attributes)
////        }
////        return presentedViewController
////    }
//}
