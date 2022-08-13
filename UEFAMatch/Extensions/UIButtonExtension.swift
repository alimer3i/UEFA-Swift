//
//  UIButtonExtension.swift
//  PalmReading
//
//  Created by Ali Merhie on 8/27/19.
//  Copyright © 2019 Monty Mobile. All rights reserved.
//

import Foundation
import UIKit
//import TextImageButton

extension UIButton {
    
    func addBottomBorder(color: UIColor) -> CALayer {
        let width = self.frame.size.width
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x:0, y: self.frame.size.height - 1, width:width, height: 1)
        self.layer.addSublayer(border)
        return border
    }
    func setTintedImage(named: String, state: UIControl.State ){
        let origImage = UIImage(named: named)
        let tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
        self.setImage(tintedImage, for: state)
    }
    func setUnderlinedText(title: String){
        var attrs = [
//            NSAttributedString.Key.font : UIFont.systemFont(ofSize: (self.titleLabel?.font.pointSize)!),
            NSAttributedString.Key.font : self.titleLabel?.font!,
            NSAttributedString.Key.foregroundColor : self.titleLabel?.textColor,
            NSAttributedString.Key.underlineStyle : 1] as [NSAttributedString.Key : Any]

        var attributedString = NSMutableAttributedString(string:"")
        let buttonTitleStr = NSMutableAttributedString(string: title, attributes:attrs)
                     attributedString.append(buttonTitleStr)
                     self.setAttributedTitle(attributedString, for: .normal)
    }
}

@IBDesignable
class GradientButton: RightAlignedIconButton {
    
    @IBInspectable var startColor:   UIColor = .black { didSet { updateColors() }}
    @IBInspectable var endColor:     UIColor = .white { didSet { updateColors() }}
    @IBInspectable var startLocation: Double =   0.05 { didSet { updateLocations() }}
    @IBInspectable var endLocation:   Double =   0.95 { didSet { updateLocations() }}
    @IBInspectable var horizontalMode:  Bool =  false { didSet { updatePoints() }}
    @IBInspectable var diagonalMode:    Bool =  false { didSet { updatePoints() }}
    
    override public class var layerClass: AnyClass { return CAGradientLayer.self }
    
    var gradientLayer: CAGradientLayer { return layer as! CAGradientLayer }
    
    func updatePoints() {
        if horizontalMode {
            gradientLayer.startPoint = diagonalMode ? CGPoint(x: 1, y: 0) : CGPoint(x: 0, y: 0.5)
            gradientLayer.endPoint   = diagonalMode ? CGPoint(x: 0, y: 1) : CGPoint(x: 1, y: 0.5)
        } else {
            gradientLayer.startPoint = diagonalMode ? CGPoint(x: 0, y: 0) : CGPoint(x: 0.5, y: 0)
            gradientLayer.endPoint   = diagonalMode ? CGPoint(x: 1, y: 1) : CGPoint(x: 0.5, y: 1)
        }
    }
    func updateLocations() {
        gradientLayer.locations = [startLocation as NSNumber, endLocation as NSNumber]
    }
    func updateColors() {
        gradientLayer.colors    = [startColor.cgColor, endColor.cgColor]
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        updatePoints()
        updateLocations()
        updateColors()
    }
}
