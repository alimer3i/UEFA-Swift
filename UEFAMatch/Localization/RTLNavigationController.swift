//
//  RTLNavigationController.swift
//  PalmReading
//
//  Created by Ali Merhie on 9/23/19.
//  Copyright © 2019 Monty Mobile. All rights reserved.
//

import Foundation
import UIKit

final class RTLNavigationController: UINavigationController, UINavigationControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }
    
    func navigationController(_ navigationController: UINavigationController,
                              didShow viewController: UIViewController,
                              animated: Bool) {
        let direction: UISemanticContentAttribute = currentLanguageIsRTL ? .forceRightToLeft : .forceLeftToRight
        navigationController.view.semanticContentAttribute = direction
        navigationController.navigationBar.semanticContentAttribute = direction
        
    }
}
