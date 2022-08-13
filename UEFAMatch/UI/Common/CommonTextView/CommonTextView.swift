//
//  UnderlinedTextView.swift
//  MRewards
//
//  Created by Ali Merhie on 1/31/20.
//  Copyright © 2020 Monty Mobile. All rights reserved.
//

import UIKit
import TweeTextField

class CommonTextView: UIView {
    @IBInspectable var isPassword: Bool = true{
        didSet {
            updateIsPassword()
        }
    }


    @IBOutlet var view: UIView!
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var textHolderView: UIView!
    @IBOutlet weak var textField: ExtendedTweeAttributedTextField!{
        didSet{
            self.textField.addTarget(self, action: #selector(textFieldDidChange), for: UIControl.Event.editingChanged)

        }
    }
    @IBOutlet weak var hideButton: UIButton!
    var text: String? {
        get{
            return textField.text
        }
        set{
            textField.text = newValue
        }
    }
    var placeHolder: String {
        get{
            return textField.placeholder ?? ""
        }
        set{
            textField.placeholder = newValue
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    init() {
        super.init(frame: .infinite)
        setup()
    }
    private func setup(){
        Bundle.main.loadNibNamed("CommonTextView", owner: self, options: nil)
        self.addSubview(view)
        addConstraints()
        
    }
    @objc func textFieldDidChange(_ textField: UITextField) {
        //self.textField.hideInfo()
        self.textField.showInfo("", animated: false)
        
    }
    public func showError(message: String){
        if message != ""{
        self.view.shake()
        }
        self.textField.showInfo(message, animated: false)
    }
    private func updateIsPassword(){
        textField.isSecureTextEntry = isPassword
        hideButton.isHidden = !isPassword
        hideButton.setTintedImage(named: "eye", state: .normal)
        hideButton.tintColor = R.color.primary()
    }

//    private func updateIsWhiteView(){
//        textHolderView.backgroundColor = .white
//        textHolderView.borderWidth = 1
//        textHolderView.borderColor = .greyLight
//    }
    
    @IBAction func hideClicked(_ sender: Any) {
        textField.isSecureTextEntry = !textField.isSecureTextEntry
        hideButton.tintColor = textField.isSecureTextEntry ? .blue : R.color.primary()
    }
    func addConstraints() {
        view.translatesAutoresizingMaskIntoConstraints = false
        var anchors = [NSLayoutConstraint]()
        anchors.append(topAnchor.constraint(equalTo: view.topAnchor, constant: 0))
        anchors.append(bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0))
        anchors.append(leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0))
        anchors.append(trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0))
        NSLayoutConstraint.activate(anchors)
        
    }
    
}
