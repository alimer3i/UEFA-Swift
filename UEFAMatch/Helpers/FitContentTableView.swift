//
//  FitContentTableView.swift
//  VirtualNumber
//
//  Created by Ali Merhie on 1/10/22.
//

import UIKit

class FitContentTableView: UITableView {

    override var contentSize:CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }
    
    override var intrinsicContentSize: CGSize {
        layoutIfNeeded()
        return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
    }

}
