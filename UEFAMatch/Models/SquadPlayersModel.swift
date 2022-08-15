//
//  SquadPlayersModel.swift
//  UEFAMatch
//
//  Created by Ali Merhie on 8/13/22.
//

import Foundation
import ObjectMapper

class SquadPlayersModel: Mappable, Codable {
    
    var sectionTitle: String?
    var players: [PlayerModel] = []

    init() {
        
    }
    init(sectionTitle: String, players: [PlayerModel]){
        self.sectionTitle = sectionTitle
        self.players = players
    }
    
    required init?(map: Map) {
        sectionTitle <- map["sectionTitle"]
        players <- map["players"]
    }
    
    func mapping(map: Map) {
        
    }
}
