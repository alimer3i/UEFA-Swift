//
//  MainViewController.swift
//  UEFAMatch
//
//  Created by Ali Merhie on 8/13/22.
//

import UIKit

class MainViewController: BaseViewController<MainVM> {

    @IBOutlet weak var UCLButton: UIButton!
    @IBOutlet weak var UELButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        UCLButton.setTitle("UCL", for: .normal)
        UELButton.setTitle("UEL", for: .normal)
        // Do any additional setup after loading the view.
    }

    @IBAction func UCLButtonClicked(_ sender: Any) {
       let vc = HeaderTabViewController.pushVC(mainView: self)
        vc.viewModel.selectedPageType = .UCL
    }
    @IBAction func UELButtonClicked(_ sender: Any) {
        let vc = HeaderTabViewController.pushVC(mainView: self)
         vc.viewModel.selectedPageType = .UEL
    }
}
