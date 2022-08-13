//
//  UpdateViewController.swift
//  VirtualNumber
//
//  Created by Joe Maghzal on 24/05/2022.
//

import UIKit

class UpdateViewController: BaseViewController<UpdateViewModel> {
//MARK: - Properties
    override class var pageStoryBoard: AppStoryboard {
        get { return .AppUpdate }
    }
//MARK: - Outlets
    @IBOutlet weak var updateLabel: UILabel!
    @IBOutlet weak var updateTitleLabel: UILabel!
    @IBOutlet weak var updateImage: UIImageView!
    @IBOutlet weak var updateButton: UIButton!
    @IBOutlet weak var laterButton: UIButton!
    @IBOutlet weak var ignoreButton: UIButton!
//MARK: - ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
//MARK: - Actions
    @IBAction func buttonsTapped(_ sender: UIButton) {
        guard let tag = UpdateButton(rawValue: sender.tag) else {return}
        switch tag {
        case .update:
            AppStore.shared.openAppInAppStore(self)
        case .later:
            self.dismiss(animated: true)
        case .ignore:
            self.dismiss(animated: true) {
                AppSettings.ignoresUpdates = true
            }
        }
    }
//MARK: - Functions
    func setUp() {
        let currentVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
        updateLabel.text = """
A new version of \(Bundle.main.displayName) is available! Version \(AppUpdateHelper.shared.version) is now available-you have \(currentVersion).

Would you like yo update it now?
"""
        updateTitleLabel.text = "Update App!"
        laterButton.setTitle("Later", for: .normal)
        ignoreButton.setTitle("Ignore", for: .normal)
        updateButton.setTitle("Update Now", for: .normal)
        updateImage.image = UIImage(named: "updateImage")
        laterButton.isHidden = AppUpdateHelper.shared.forceUpdate
        ignoreButton.isHidden = laterButton.isHidden
    }
}
