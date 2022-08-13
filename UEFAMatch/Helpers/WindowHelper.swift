//
//  WindowHelper.swift
//  SelfCare
//
//  Created by Ali Merhie on 10/30/19.
//  Copyright © 2019 Monty Mobile. All rights reserved.
//

import Foundation
import UIKit

final class WindowHelper {
    public var window: UIWindow
    static let shared = WindowHelper()
    
    private init() {
        window = AppDelegate.shared.window!
    }
}
