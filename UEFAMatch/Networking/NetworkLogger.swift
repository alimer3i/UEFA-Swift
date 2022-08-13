//
//  NetworkLogger.swift
//  RBT
//
//  Created by Ali Merhie on 22/07/2021.
//

import Foundation
import Alamofire

class NetworkLogger: EventMonitor {
    
//    let queue = DispatchQueue(label: "")
    
    func requestDidFinish(_ request: Request) {
        print("---------------------------Request Begin---------------------------------")
        print(request.description)
        
    }
    
    func request<Value>(_ request: DataRequest, didParseResponse response: DataResponse<Value, AFError>) {
        guard let data = response.data else {
            return
        }
        displayRequestData(request: request, data: data)
        
    }
    
    func request(_ request: DataRequest, didParseResponse response: DataResponse<Data?, AFError>) {
        guard let data = response.data else {
            return
        }
        
        displayRequestData(request: request, data: data)
        
    }
    private func displayRequestData(request: DataRequest, data: Data){

        print("REQUEST: \(request.cURLDescription())" )
        
        if let json = try? JSONSerialization
            .jsonObject(with: data, options: .mutableContainers) {
            print("RESPONSE \(json)")
        }

        print("---------------------------Request Done---------------------------------")
    }
    
    
    func request(_ request: Request, didFailToCreateURLRequestWithError error: AFError) {
        
    }
}

