//
//  UiSliderExtension.swift
//  SelfCare
//
//  Created by Ali Merhie on 11/6/19.
//  Copyright © 2019 Monty Mobile. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
    class CustomSlider: UISlider {
       /// custom slider track height
       @IBInspectable var trackHeight: CGFloat = 3
     @IBInspectable  var ThumbImage: UIImage?

    override func awakeFromNib() {
        super.awakeFromNib()
        self.setThumbImage(ThumbImage, for: .normal)
    }
       override func trackRect(forBounds bounds: CGRect) -> CGRect {
           // Use properly calculated rect
           var newRect = super.trackRect(forBounds: bounds)
           newRect.size.height = trackHeight
           return newRect
       }
    
}
