//
//  RequestInterceptor.swift
//  RBT
//
//  Created by Ali Merhie on 22/07/2021.
//

import Foundation
import Alamofire
import UIKit
import ObjectMapper

class RequestInterceptor: Alamofire.RequestInterceptor {
    
    private var isRefreshing = false
    let retryLimit = 5
    let failedRetryLimit = 2
    let retryDelay: TimeInterval = 1
    private var requestsToRetry: [((RetryResult) -> Void)] = []
    private let lock = NSLock()
    
    
    func adapt( _ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        
        var urlRequest = urlRequest
        
        if let urlString = urlRequest.url?.absoluteString{
            
            if !(urlString.contains(AccountAPI.refreshToken.path) || urlString.contains(AccountAPI.forgetPassword(phoneCode: "", phoneNumber: "").path) || urlString.hasPrefix(AccountAPI.resetPassword(userID: 0, otp: "", newPassord: "").path) || urlString.contains(AccountAPI.resendOTP(userID: 0).path) || urlString.contains(AccountAPI.resendResetOTP(userID: 0).path) || urlString.contains(AccountAPI.validateResetOTP(userID: 0, otp: "").path) || urlString.contains(AccountAPI.login(phoneCode: "", phoneNumber: "", password: "", grecaptchaResponse: "").path) || urlString.contains(AccountAPI.register(phoneCode: "", phoneNumber: "", password: "", fullName: "").path) || urlString.contains(AccountAPI.verify(userID: 0, otp: "").path) || urlString.contains(AccountAPI.resetPassword(userID: 0, otp: "", newPassord: "").path)){
                urlRequest.setValue("Bearer " + AppSettings.token, forHTTPHeaderField: "Authorization")
            }
            urlRequest.setValue(DeviceHelper.deviceUniqueId, forHTTPHeaderField: "appInstanceId")
        }
        
        print(urlRequest)
        completion(.success(urlRequest))
    }
    
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        
        if let response = request.task?.response as? HTTPURLResponse{
            let statusCode = response.statusCode
            
            lock.lock() ; defer { lock.unlock() }
            let urlString = (response.url?.absoluteString) ?? ""
            
            print("error: \(error)")
            print(request.retryCount)
            
            //        return
            //        if let afError = error.asAFError {
            //            print(afError)
            //
            //        }
            
            switch statusCode {
            case 401:
                //in case refredsh token api returs 401 the try again
                if urlString.contains(AccountAPI.refreshToken.path){
                    //                    if request.retryCount < 3{}
                    completion(.doNotRetry)
                    expireSession()
                    return
                }
                //append all 401 requests in oreder to complete action after refresh is done
                if request.retryCount < 3{
                    requestsToRetry.append(completion)
                }else{
                    completion(.doNotRetry)
                    self.endRefreshing(retry: false)
                    return
                }
                
                if !isRefreshing{
                    isRefreshing = true
                    
                    refreshToken { isSuccess, error  in
                        //                        self.lock.lock() ; defer { self.lock.unlock() }
                        self.endRefreshing(retry: isSuccess)
                        
                        if !isSuccess{
                            self.expireSession()
                        }
                    }
                }
                break
            case 500...599:
                
                if request.retryCount < failedRetryLimit {
                    completion(.retryWithDelay(retryDelay))
                }else{
                    self.handleErrorResponseResponse(request: request)
                    completion(.doNotRetry)
                }
                break
            default:
                self.handleErrorResponseResponse(request: request)
                completion(.doNotRetry)
                break
            }
            
        }else{
            completion(.doNotRetry)
        }
    }
    
    private func refreshToken( completion :@escaping (Bool,Error?)->Void){
        //        completion(true,nil)
        
        ServiceLayer.request(router: AccountAPI.refreshToken, model: ErrorResponseModel.self) { result in
            switch result{
            case .success(let baseModel):
//                if let token = baseModel.data?.token {
//                    AppSettings.token = token
//                }
//                if let refreshToken = baseModel.data?.refreshToken {
//                    AppSettings.refreshtoken = refreshToken
//                }
                completion(true,nil)
                break
            case .failure(_):
                completion(false,nil)
                break
            }
        }
        
    }
    private func endRefreshing(retry: Bool){
        self.requestsToRetry.forEach { $0(retry ? .retry : .doNotRetry) }
        self.requestsToRetry.removeAll()
        self.isRefreshing = false
    }
    
    private func expireSession(){
        endRefreshing(retry: false)
    }
    
    private func handleErrorResponseResponse(request:Request){
        
        if let response = request.task?.response as? HTTPURLResponse {
            let fullURL = response.url?.absoluteString ?? ""
            guard let data = (request as? DataRequest)?.data else{
//                DispatchQueue.main.async {
//                    UIApplication.getTopViewController()?.showAlert(title: "Oops! Something went wrong!", message: "The application has encountered an unknown error,but our technical staff have been automatically notified and will be looking into this with the utmost urgency.", completion: nil)
//                }
                print("failed to read response data")
                return
            }
            
            if fullURL.contains(AccountAPI.refreshToken.baseURL.absoluteString) {
                do {
                    var errorBlock = BaseModel<ErrorResponseModel>()
                    
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        errorBlock = Mapper<BaseModel<ErrorResponseModel>>().map(JSON: json)!
                    }else{
                        print("error serializing api body response")
                        return
                    }
                    
                    self.discardShowingAlertForSomeAPI(fullURL: fullURL, responseCode: errorBlock.responseCode) { (shouldSkip) in
                        
                        if shouldSkip {
                            print("Api error alert skipped")
                            return
                        }
                        
                        DispatchQueue.main.async {
//                            UIApplication.getTopViewController()?.showAlert(title: errorBlock.titleMessage , message: (errorBlock.message ?? "Unkown Error"), buttonTitles: ["OK"], completion: { (int) in })
                        }
                    }
                } catch let error as NSError {
                    print("Failed to load: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func discardShowingAlertForSomeAPI(fullURL:String, responseCode: Int = 0, completion:((Bool)->())){
        switch fullURL {
        case let str where str.lowercased().contains(AccountAPI.login(phoneCode: "", phoneNumber: "", password: "", grecaptchaResponse: "").path) && responseCode == ResponseCodesEnum.accountNotVerified.rawValue:
            completion(true)
            break
        default:
            completion(false)
            break
        }
    }
}

