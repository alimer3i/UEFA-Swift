//
//  PlayerModel.swift
//  UEFAMatch
//
//  Created by Ali Merhie on 8/13/22.
//

import Foundation
import ObjectMapper

class PlayerModel: Mappable, Codable {
    var name: String?
    var number: Int?
    var country: String?
    var playerImage: String?
    
    init() {
        
    }
    init(name: String, number: Int, country: String, playerImage: String){
        self.name = name
        self.number = number
        self.country = country
        self.playerImage = playerImage

    }
    
    required init?(map: Map) {
        name <- map["name"]
        number <- map["number"]
        country <- map["country"]
        playerImage <- map["playerImage"]

    }
    
    func mapping(map: Map) {
        
    }
}
