//
//  AccountAPI.swift
//  RBT
//
//  Created by Ali Merhie on 09/09/2021.
//

import Foundation
import Alamofire
import FCUUID
import ObjectMapper

enum AccountAPI:URLRequestBuilder {
    
    case login(phoneCode: String, phoneNumber:String, password:String, grecaptchaResponse: String)
    case register(phoneCode: String, phoneNumber:String, password:String, fullName:String)
    case verify(userID:Int,otp:String)
    case resendOTP(userID:Int)
    case forgetPassword(phoneCode: String, phoneNumber:String)
    case resendResetOTP(userID:Int)
    case validateResetOTP(userID: Int, otp: String)
    case resetPassword(userID:Int,otp:String,newPassord:String)
    case refreshToken
    case updateUserDevice(fcmToken: String)
    case getUserInfo
    case updateUserInfo(name: String)
    case changePassword(oldPassword: String, newPassword: String)
    
    case faq
    case getTerms
    case submitHelp(title: String, message: String)
    case getNotifications(page: Int, size: Int)
    case getNotificationCount
    case setNotificationsUnseen

    
    var path: String{
        switch self {
        case .login:
            return "/api/v1/user/auth/signin"
        case .register:
            return "/api/v1/user/auth/register"
        case .forgetPassword:
            return "/api/v1/user/auth/forgetPassword"
        case .resendOTP:
            return "api/v1/user/auth/resendRegisterOtp"
        case .refreshToken:
            return "/api/v1/user/auth/refreshToken"
        case .verify:
            return "/api/v1/user/auth/verify"
        case .resetPassword:
            return "/api/v1/user/auth/resetPassword"
        case .faq:
            return "/api/v1/faqs"
        case .resendResetOTP:
            return "/api/v1/user/auth/resendForgetOtp"
        case .validateResetOTP:
            return "/api/v1/user/auth/validateResetOtp"
        case .updateUserDevice:
            return "/api/v1/userDevice"
        case .getUserInfo:
            return "/api/v1/info"
        case .updateUserInfo:
            return "/api/v1/user/info"
        case .changePassword:
            return "/api/v1/user/changePassword"
        case .getTerms:
            return "/api/v1/terms"
        case .submitHelp:
            return "/api/v1/help-center"
        case .getNotifications:
            return "/api/v1/notification"
        case .getNotificationCount:
            return "/api/v1/notification/total-unread"
        case .setNotificationsUnseen:
            return "/api/v1/notification/update-read-notification"
        }
    }
    
    var headers: HTTPHeaders {
        var header = HTTPHeaders()
        switch self {
        case .refreshToken:
            header.add(HTTPHeader(name: "refreshToken", value: "Bearer \(AppSettings.refreshtoken)"))
            return header
        case .login:
            header.add(HTTPHeader(name: "ios", value: "12"))
            return header
        default:
            return header
        }
    }
    var parameters: Parameters?{
        switch self {
        case .login(let phoneCode, let phoneNumber,let password, let captcha):
            return [
                "phoneCode" : phoneCode,
                "phoneNumber" : phoneNumber,
                "password" : password,
                "grecaptchaResponse": captcha
            ]
        case .register(let phoneCode, let phoneNumber,let password,let fullName):
            return [
                "fullName" : fullName,
                "phoneCode" : phoneCode,
                "phoneNumber" : phoneNumber,
                "password" : password
            ]
        case .forgetPassword(let phoneCode,let phoneNumber):
            return [
                "phoneCode" : phoneCode,
                "phoneNumber" : phoneNumber
            ]
        case .resendOTP(let userID):
            return [
                "userId" : userID,
            ]
        case .resendResetOTP(let userID):
            return [
                "userId" : userID,
            ]
        case .refreshToken:
            return [
                "refreshToken" : AppSettings.refreshtoken
                //                "deviceId":UserPreferences.deviceID
            ]
        case .verify(let userID,let otp):
            return [
                "userId" : userID,
                "otp":otp
            ]
        case .resetPassword(let userID,let otp, let newPassword):
            return [
                "userId" : userID,
                "otp" : otp,
                "newPassword" : newPassword
            ]
        case .validateResetOTP(let userID, let otp):
            return ["userId" : userID,
                    "otp" : otp
            ]
        case .updateUserDevice(let fcmToken):
            return ["fcmToken" : fcmToken,
                    "osVersion" :  DeviceHelper.systemVersion,
                    "phoneName" : DeviceHelper.name,
                    "os" : DeviceHelper.systemName,
                    "model" : DeviceHelper.modelString,
                    "brand" : "Apple",
                    "mnc" : DeviceHelper.mobileNetworkCode,
                    "mcc" : DeviceHelper.mobileCountryCode,
                    "appVersion" : DeviceHelper.appVersion,
                    "systemInfo" : DeviceHelper.systemInfo,
                    "operatorName" : DeviceHelper.CarrierName
            ]
        case .updateUserInfo(let name):
            return ["fullName" : name
            ]
        case .changePassword(let oldPassword, let newPassword):
            return ["password" : oldPassword,
                    "newPassword" : newPassword
            ]
        case .submitHelp(let title, let message):
            return ["title" : title,
                    "message" : message
            ]
        case .getNotifications(let page, let size):
            return ["page" : page,
                    "size" : size
            ]
        case .setNotificationsUnseen:
            return ["isRead" : "true"
                    ]
            
        default:
            return nil
        }
    }
    
    var method: HTTPMethod{
        switch  self {
        case .login,.register,.forgetPassword,.resendOTP,.resendResetOTP,.refreshToken,.validateResetOTP,.verify,.resetPassword, .changePassword, .submitHelp:
            return HTTPMethod.post
        case .faq, .getUserInfo, .getTerms, .getNotifications, .getNotificationCount:
            return HTTPMethod.get
        case .updateUserDevice, .updateUserInfo, .setNotificationsUnseen:
            return HTTPMethod.put
        }
    }
}
