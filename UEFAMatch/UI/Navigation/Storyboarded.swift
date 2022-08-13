//
//  Storyboarded.swift
//  VirtualNumber
//
//  Created by Ali Merhie on 8/30/21.
//

import Foundation
import UIKit

enum AppStoryboard : String {
    case Main, PreSignIn, OnBoard, VNSubscription, Others, AppUpdate
    var instance : UIStoryboard {
      return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }
}

protocol Storyboarded {
    static var pageStoryBoard: AppStoryboard { get }
    
    static func instantiate() -> Self
    
    static func instantiateFromXIB() -> Self

}

extension Storyboarded where Self: UIViewController  {

    static func instantiate() -> Self {
        let id = String(describing: self)
        let currentStoryBoard = Self.pageStoryBoard
        let viewController = currentStoryBoard.instance.instantiateViewController(withIdentifier: id) as! Self
        return viewController
    }
    
    static func instantiateFromXIB() -> Self {
        let id = String(describing: self)
//        let storyboard = UIStoryboard(name: storyboard.rawValue, bundle: Bundle.main)
        let x = Self(nibName: id, bundle: nil)
//        let viewController = storyboard.instantiateViewController(withIdentifier: id) as! Self
        return x
    }
}
