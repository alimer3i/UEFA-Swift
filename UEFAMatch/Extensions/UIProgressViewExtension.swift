//
//  UIProgressViewExtension.swift
//  CallerRate
//
//  Created by Ali Merhie on 1/16/20.
//  Copyright © 2020 Monty Mobile. All rights reserved.
//

import Foundation
import UIKit

extension UIProgressView {

    @IBInspectable var barHeight : CGFloat {
        get {
            return transform.d * 2.0
        }
        set {
            // 2.0 Refers to the default height of 2
            let heightScale = newValue / 2.0
            let c = center
            transform = CGAffineTransform(scaleX: 1.0, y: heightScale)
            center = c
        }
    }
}
