//
//  buttonHelpers.swift
//  PalmReading
//
//  Created by Ali Merhie on 10/9/19.
//  Copyright © 2019 Monty Mobile. All rights reserved.
//

import Foundation
import UIKit


//class ButtonWithRightImage: UIButton {
//    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        if imageView != nil {
//            imageEdgeInsets = UIEdgeInsets(top: 5, left: (bounds.width - 35), bottom: 5, right: 5)
//            titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: (imageView?.frame.width)!)
//        }
//    }
//}


class ButtonWithTopImage: UIButton {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if imageView != nil {
            var padding: CGFloat = 6.0
            guard   let imageViewSize = self.imageView?.frame.size,
                let titleLabelSize = self.titleLabel?.frame.size else {
                    return
            }
            
            let totalHeight = imageViewSize.height + titleLabelSize.height + padding
            
            self.imageEdgeInsets = UIEdgeInsets(
                top: -(totalHeight - imageViewSize.height) + 15,
                left: 0.0,
                bottom: 0.0,
                right: -titleLabelSize.width
            )
            
            self.titleEdgeInsets = UIEdgeInsets(
                top: 0.0,
                left: -imageViewSize.width,
                bottom: -(totalHeight - titleLabelSize.height) - 15,
                right: 0.0
            )
            
            self.contentEdgeInsets = UIEdgeInsets(
                top: 0.0,
                left: 0.0,
                bottom: titleLabelSize.height,
                right: 0.0
            )
        }
    }
}
@IBDesignable
class LeftAlignedIconButton: UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        if !currentLanguageIsRTL {
            contentHorizontalAlignment = .left
            let availableSpace = bounds.inset(by: contentEdgeInsets)
            let availableWidth = availableSpace.width - imageEdgeInsets.right - (imageView?.frame.width ?? 0) - (titleLabel?.frame.width ?? 0)
            imageEdgeInsets = UIEdgeInsets(top: 5, left: 15 , bottom: 5, right: 0)
            titleEdgeInsets = UIEdgeInsets(top: 0, left: availableWidth / 2, bottom: 0, right: 0)
        }else{
            semanticContentAttribute = .forceRightToLeft
            contentHorizontalAlignment = .right
            let availableSpace = bounds.inset(by: contentEdgeInsets)
            let availableWidth = availableSpace.width - imageEdgeInsets.left - (imageView?.frame.width ?? 0) - (titleLabel?.frame.width ?? 0)
            imageEdgeInsets = UIEdgeInsets(top: 5, left: 15 , bottom: 5, right: 15)
            titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: availableWidth / 2)
        }
        
    }
}
@IBDesignable
class RightAlignedIconButton: UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        if !currentLanguageIsRTL {
            
            semanticContentAttribute = .forceRightToLeft
            contentHorizontalAlignment = .right
            let availableSpace = bounds.inset(by: contentEdgeInsets)
            let availableWidth = availableSpace.width - imageEdgeInsets.left - (imageView?.frame.width ?? 0) - (titleLabel?.frame.width ?? 0)
            imageEdgeInsets = UIEdgeInsets(top: 5, left: 15 , bottom: 5, right: 15)
            titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: availableWidth / 2)
        }else{
            contentHorizontalAlignment = .left
            let availableSpace = bounds.inset(by: contentEdgeInsets)
            let availableWidth = availableSpace.width - imageEdgeInsets.right - (imageView?.frame.width ?? 0) - (titleLabel?.frame.width ?? 0)
            imageEdgeInsets = UIEdgeInsets(top: 5, left: 15 , bottom: 5, right: 0)
            titleEdgeInsets = UIEdgeInsets(top: 0, left: availableWidth / 2, bottom: 0, right: 0)
        }
    }
}
