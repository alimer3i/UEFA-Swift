//
//  ErrorResponseModel.swift
//  VirtualNumber
//
//  Created by Ali Merhie on 9/28/21.
//

import Foundation
import ObjectMapper
import Alamofire

class ErrorResponseModel: Error, Mappable, Codable {
    
    var statusCode: Int = 1
    var status: Bool = false
    var responseCode: Int = -1
    var message: String = "Defualt Error"
    var titleMessage: String = "Error"
    @NotCoded
    var error: AFError?
    
    required init?(map: Map) {
        status <- map["status"]
        responseCode <- map["responseCode"]
        message <- map["message"]
        titleMessage <- map["title"]
        
    }
    init<T: Mappable & Codable>(base: BaseModel<T>, error: AFError?, statusCode: Int) {
        self.statusCode = statusCode
        self.status = base.status
        self.responseCode = base.responseCode
        self.message = base.message
        self.titleMessage = base.titleMessage
        self.error = error
        
        
    }
    init() {
        
    }
    
    func mapping(map: Map) {
        
    }
    
}
