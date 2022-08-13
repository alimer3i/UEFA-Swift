//
//  PlayersMockData.swift
//  UEFAMatch
//
//  Created by Ali Merhie on 8/13/22.
//

import Foundation

class PlayersMockData {
    
    class func getUclPlayers() -> [SquadPlayersModel]{
        let goalKeepers = SquadPlayersModel(sectionTitle: "GoalKeepers",
                                            players: [PlayerModel(name: "Player 1", number: 1, country: "UK", playerImage: ""),
                                                      PlayerModel(name: "Player 2", number: 2, country: "UK", playerImage: ""),
                                                      PlayerModel(name: "Player 3", number: 3, country: "UK", playerImage: ""),
                                                      PlayerModel(name: "Player 4", number: 4, country: "UK", playerImage: "")])
        
        let defenders = SquadPlayersModel(sectionTitle: "Defenders",
                                            players: [PlayerModel(name: "Player 1", number: 1, country: "UK", playerImage: ""),
                                                      PlayerModel(name: "Player 2", number: 2, country: "UK", playerImage: ""),
                                                      PlayerModel(name: "Player 3", number: 3, country: "UK", playerImage: ""),
                                                      PlayerModel(name: "Player 4", number: 4, country: "UK", playerImage: "")])
        
        let forwards = SquadPlayersModel(sectionTitle: "Forwards",
                                            players: [PlayerModel(name: "Player 1", number: 1, country: "UK", playerImage: ""),
                                                      PlayerModel(name: "Player 2", number: 2, country: "UK", playerImage: ""),
                                                      PlayerModel(name: "Player 3", number: 3, country: "UK", playerImage: ""),
                                                      PlayerModel(name: "Player 4", number: 4, country: "UK", playerImage: "")])
        let couach = SquadPlayersModel(sectionTitle: "Couch",
                                            players: [PlayerModel(name: "Player 1", number: 1, country: "UK", playerImage: "")])
        
        return [goalKeepers, defenders, forwards, couach]
    }
}
