//
//  LocalizationExtensions.swift
//  PalmReading
//
//  Created by Ali Merhie on 9/23/19.
//  Copyright © 2019 Monty Mobile. All rights reserved.
//

import Foundation
import UIKit
//import TextImageButton

extension UIView {
    private static let _preventRTL = ObjectAssociation<Bool>()
    @IBInspectable var preventRTL: Bool {
        get { return UIView._preventRTL[self] ?? false }
        set { UIView._preventRTL[self] = newValue }
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        if preventRTL {
            semanticContentAttribute = .forceLeftToRight
        } else {
            semanticContentAttribute = currentLanguageIsRTL ? .forceRightToLeft : .forceLeftToRight
        }
    }
}

extension UITextField {
    open override func awakeFromNib() {
        super.awakeFromNib()
        if textAlignment != .center, !self.preventRTL {
            self.textAlignment = currentLanguageIsRTL ? .right : .left
        }
    }
}

extension UILabel {
    open override func awakeFromNib() {
        super.awakeFromNib()
        adjustsFontSizeToFitWidth = true
        if textAlignment != .center, !self.preventRTL {
            self.textAlignment = currentLanguageIsRTL ? .right : .left
        }
    }
}
extension UIImageView {
    open override func awakeFromNib() {
        super.awakeFromNib()
        if  !self.preventRTL {
            self.transform = currentLanguageIsRTL ? CGAffineTransform(scaleX: -1, y: 1) : CGAffineTransform(scaleX: 1, y: 1)
            
        }
    }
}
extension UIButton {
    open override func awakeFromNib() {
        super.awakeFromNib()
        if  !self.preventRTL {
            self.imageView?.transform = currentLanguageIsRTL ? CGAffineTransform(scaleX: -1, y: 1) : CGAffineTransform(scaleX: 1, y: 1)
            self.semanticContentAttribute = currentLanguageIsRTL ? .forceRightToLeft : .forceLeftToRight
        }
    }
}
//extension TextImageButton {
//    open override func awakeFromNib() {
//        super.awakeFromNib()
//        if  !self.preventRTL {
//            self.imageOnRight =  currentLanguageIsRTL ? !self.imageOnRight : self.imageOnRight
//        }
//    }
//}
//extension UIScrollView {
//    open override func awakeFromNib() {
//        super.awakeFromNib()
//        if  !self.preventRTL {
//            self.transform = currentLanguageIsRTL ? CGAffineTransform(scaleX: -1, y: 1) : CGAffineTransform(scaleX: 1, y: 1)
//            
//            for view in self.subviews{
//                view.transform =  currentLanguageIsRTL ? CGAffineTransform(scaleX: -1, y: 1) : CGAffineTransform(scaleX: 1, y: 1)
//                
//            }
//        }
//    }
//}
