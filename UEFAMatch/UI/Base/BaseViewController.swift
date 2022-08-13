//
//  BaseViewController.swift
//  VirtualNumber
//
//  Created by Ali Merhie on 8/30/21.
//

import Foundation
import UIKit
import MBProgressHUD
import SkeletonView
import Combine

class BaseViewController<Element: BaseVM>: UIViewController, Storyboarded, ScreenLoader {
    
    class var pageStoryBoard: AppStoryboard { get { return .Main } }
    internal var viewModel = Element()
    var isLightStatus = false
    var cancellables = Set<AnyCancellable>()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if #available(iOS 13.0, *) {
            UIApplication.shared.statusBarStyle = isLightStatus ? .lightContent : .darkContent
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        bindToViewModel()
        
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        // notification to reload the page once teh connection is returned if it was lost, it will be called from ApiServices page
        //        NotificationCenter.default.addObserver(self, selector: #selector(reloadPage(_:)), name: .internetConnectionBack, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleAppDidBecomeActiveNotification(notification:)), name: UIApplication.didBecomeActiveNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    internal func bindToViewModel() {
        viewModel.$isLoading
            .sink { [weak self] isLoading in
                guard let strongSelf = self else {return}
                if isLoading {
                    let hud = MBProgressHUD.showAdded(to: (self?.view) ?? UIView() , animated: true)
                    hud.label.text = "Loading"
                    hud.isUserInteractionEnabled = true
                    
                }else {
                    MBProgressHUD.hide(for: (self?.view) ?? UIView() , animated: true)
                }
            }.store(in: &cancellables)

        viewModel.$isSkeletonAnimating
            .sink { [weak self] isAnimating in
                guard let strongSelf = self else {return}
                if isAnimating {
                    ((self?.view) ?? UIView()).showAnimatedGradientSkeleton()
                }else {
                    ((self?.view) ?? UIView()).hideSkeleton()
                }
            }.store(in: &cancellables)
        
        viewModel.$displayAlert
            .sink { [weak self] data  in
                guard let strongSelf = self else {return}
                strongSelf.showAlert(title: data?.0, message: data?.1)
            }.store(in: &cancellables)
        
    }
    internal func displayAlert(title: String, message: String, cancelText: String) {
        //        let vc = UIApplication.getTopViewController()
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancel = UIAlertAction(title: cancelText, style: .cancel, handler: nil)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
    
    internal func displayConfirmAlert(title: String, message: String, confirmText: String, cancelText: String, completion: @escaping (Bool) -> () ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancel = UIAlertAction(title: cancelText, style: .destructive,  handler: { (action) in completion(false) })
        let confirm = UIAlertAction(title: confirmText, style: .default, handler: { (action) in completion(true) })
        
        alert.addAction(cancel)
        alert.addAction(confirm)
        
        self.present(alert, animated: true, completion: nil)
    }
    @IBAction func backPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }

    @objc func handleAppDidBecomeActiveNotification(notification: Notification) {
        print("did become active \(self)")
    }
    @objc func willEnterForeground() {
        print("will enter foreground \(self)")
    }
    @objc func keyboardWillAppear() {
        print("keyboard will appear")
    }
    
    @objc func keyboardWillDisappear() {
        print("keyboard will disappear")
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        print("Memory to be released soon \(self)")
    }
    
}
//extension BaseViewController: BaseViewControllerDelegate{
//    public  func startSkeletonAnimation(){
//        //let gradient = SkeletonGradient(baseColor: UIColor(named: "charcoalGrey")!)
//        self.view.showAnimatedGradientSkeleton()
//    }
//    public  func hideSkeletonAnimation(){
//        view.hideSkeleton(reloadDataAfter: false, transition: .crossDissolve(0.5))
//    }
//}
//
