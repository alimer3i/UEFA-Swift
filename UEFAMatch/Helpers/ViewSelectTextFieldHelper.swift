//
//  ViewSelectTextFieldHelper.swift
//  MRewards
//
//  Created by Ali Merhie on 7/1/20.
//  Copyright © 2020 Monty Mobile. All rights reserved.
//

import Foundation
import UIKit

class ViewSelectTextFieldHelper: UIView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let tap = MyTapGestureRecognizer(target: self , action: #selector(self.selectTexField))
        tap.numberOfTapsRequired = 1
        
        self.addGestureRecognizer(tap)
        self.isUserInteractionEnabled = true
    }
    
    @objc func selectTexField(_ sender: MyTapGestureRecognizer) {
        for case let textField as UITextField in self.subviews {
            textField.becomeFirstResponder()
        }
    }
}
