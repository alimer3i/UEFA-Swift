//
//  ViewController.swift
//  VirtualNumber
//
//  Created by Ali Merhie on 8/18/21.
//

import UIKit

class JailbrokenViewController: BaseViewController<BaseVM> {
//MARK: - Properties
    override class var pageStoryBoard: AppStoryboard {
        get { return .Others }
    }
//MARK: - ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
    }
}
