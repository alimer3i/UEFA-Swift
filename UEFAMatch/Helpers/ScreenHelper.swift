
//
//  Administrator.swift
//  PalmReading
//
//  Created by Ali Merhie on 10/9/19.
//  Copyright © 2019 Monty Mobile. All rights reserved.
//

import Foundation
import UIKit

    // Screen width.
    public var screenWidth: CGFloat {
        return UIScreen.main.bounds.width
    }

    // Screen height.
    public var screenHeight: CGFloat {
        return UIScreen.main.bounds.height
    }

enum DeviceSize {
      case small
      case Medium
      case ipad
}
var deviceSize: DeviceSize? {
    switch screenWidth {
    case 0...375:
        return DeviceSize.small
    case 376...450:
        return DeviceSize.Medium
    default:
        return DeviceSize.ipad
    }
}
