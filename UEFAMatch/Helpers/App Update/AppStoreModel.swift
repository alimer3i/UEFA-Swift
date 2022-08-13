//
//  AppStoreModel.swift
//  VirtualNumber
//
//  Created by Joe Maghzal on 29/06/2022.
//

import Foundation
import ObjectMapper

class AppStoreResults: Codable, Mappable {
    var resultCount: Int?
    var results: [AppStoreID]?
    required init?(map: Map) {
    }
    func mapping(map: Map) {
        resultCount <- map["resultCount"]
        results <- map["results"]
    }
}

class AppStoreID: Codable, Mappable {
    var trackId: Int?
    required init?(map: Map) {
    }
    func mapping(map: Map) {
        trackId <- map["trackId"]
    }
}
