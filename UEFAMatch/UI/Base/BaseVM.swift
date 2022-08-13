//
//  BaseVM.swift
//  VirtualNumber
//
//  Created by Ali Merhie on 9/1/21.
//

import Foundation

class BaseVM {
    
    @Published var isLoading = false
    @Published var isSkeletonAnimating = false
    @Published var displayAlert: (String, String)?

    required init() {
        print("BASEVM")
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
        print("Memory to be released soon \(self)")
    }
}
