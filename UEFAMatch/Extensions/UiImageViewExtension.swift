//
//  UiImageViewExtension.swift
//  CallerRate
//
//  Created by Ali Merhie on 11/26/19.
//  Copyright © 2019 Monty Mobile. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    
    private struct AssociatedKey
       {
           static var rounded = "UIImageView.rounded"
       }

       @IBInspectable var rounded: Bool
       {
           get
           {
               if let rounded = objc_getAssociatedObject(self, &AssociatedKey.rounded) as? Bool
               {
                   return rounded
               }
               else
               {
                   return false
               }
           }
           set
           {
               objc_setAssociatedObject(self, &AssociatedKey.rounded, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
               layer.cornerRadius = CGFloat(newValue ? 1.0 : 0.0)*min(bounds.width, bounds.height)/2
           }
       }
//    func roundedCorner() {
//        self.layer.cornerRadius = (self.frame.size.width ?? 0.0) / 2
//        self.clipsToBounds = true
//    }
    func setBorderColor(color: UIColor){
        self.layer.borderWidth = 2.0
        self.layer.borderColor = color.cgColor
    }
    
//    func setKfImage(url: String?, imageName: String?, defualtImage: String = AvatarProfileImageName) -> UIImage{
//        if url == "" {
//            self.image = UIImage(named: defualtImage)
//            return self.image!
//        }
//        let url = URL(string: url ?? "")
//          
//          self.kf.indicatorType = .activity
//          self.kf.setImage(
//              with: url,
//              placeholder: UIImage(named: imageName ?? ""),
//              options: [
//                  .scaleFactor(UIScreen.main.scale),
//                  .transition(.fade(1)),
//                  .cacheOriginalImage
//              ])
//          {
//              result in
//              switch result {
//              case .success(let value):
//                  print("Task done for: \(value.source.url?.absoluteString ?? "")")
//              case .failure(let error):
//                  print("Job failed: \(error.localizedDescription)")
//                  self.image = UIImage(named: defualtImage)
//
//              }
//          }
//        return self.image ?? UIImage()
//    }
}
