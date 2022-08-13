//
//  BaseModel.swift
//  VirtualNumber
//
//  Created by Ali Merhie on 9/21/21.
//

import Foundation
import ObjectMapper

class BaseModel<Element: Mappable & Codable>: Mappable, Codable, Error {
    var status: Bool = false
    var data: Element?
    var dataArray: [Element] = []
    var dataInt: Int = 0
    var responseCode: Int = -1
    var message: String = "Defualt Error"
    var titleMessage: String = "Error"
    var totalCount: Int = 0

    required init?(map: Map) {
        status <- map["status"]
        data <- map["data"]
        dataArray <- map["data"]
        dataInt <- map["data"]
        responseCode <- map["responseCode"]
        message <- map["message"]
        titleMessage <- map["title"]
        totalCount <- map["totalCount"]

    }
    
    init() {
        
    }
    
    func mapping(map: Map) {
        
    }
    
}
