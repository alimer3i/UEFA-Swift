//
//  PageConfigEnum.swift
//  UEFAMatch
//
//  Created by Ali Merhie on 8/13/22.
//

import Foundation
import SwiftUI

enum PageConfigEnum: String{
    case UCL
    case UEL
    
    func tabBackgroundColor() -> UIColor{
        switch self {
        case .UCL:
            return R.color.navyLight() ?? .white
        case .UEL:
            return R.color.greyLight() ?? .white
        }
    }
    
    func selectedTabColor() -> UIColor{
        switch self {
        case .UCL:
            return R.color.aqua() ?? .white
        case .UEL:
            return R.color.orangeBurt() ?? .white
        }
    }
    func selectedCellColor() -> UIColor{
        switch self {
        case .UCL:
            return R.color.uclCellColor() ?? .white
        case .UEL:
            return R.color.uelCellColor() ?? .white
        }
    }
    func selectedTableColor() -> UIColor{
        switch self {
        case .UCL:
            return R.color.uclTableColor() ?? .white
        case .UEL:
            return R.color.uelTableColor() ?? .white
        }
    }
    func backgroundImage() -> UIImage{
        switch self {
        case .UCL:
            return R.image.uclBackGround() ?? UIImage()
        case .UEL:
            return R.image.uelBackGround() ?? UIImage()
        }
    }

}
