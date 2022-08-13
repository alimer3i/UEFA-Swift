//
//  HeaderTabVM.swift
//  UEFAMatch
//
//  Created by Ali Merhie on 8/13/22.
//

import Foundation
class HeaderTabVM: BaseVM {
    
    @Published var selectedTab: HomeTabsEnum = .overview
    @Published var selectedPageType: PageConfigEnum = .UCL
    @Published var reloadTable: Bool = true
    @Published var teamName: String = "Barcelona"
    @Published var matchName: String = "Round of 16"

    var players: [SquadPlayersModel] = []{
        didSet{
            reloadTable = true
        }
    }
    
    var numberOfSections: Int {
        return players.count
    }
    func numberofItems(at section: Int) -> Int{
        return players[section].players.count
    }
    func sectionTitle(at section: Int) -> String{
        return players[section].sectionTitle ?? ""
    }
    func viewDidLoad(){
        self.fecthData()
    }
    
    func fecthData(){
        players = PlayersMockData.getUclPlayers()
    }
    func configure(cell: PlayerTableViewCell, at indexPath: IndexPath ) {
        let player = players[indexPath.section].players[indexPath.row]
        cell.setup(name: player.name ?? "", country: player.country ?? "", number: "\(player.number ?? 0)", image: player.playerImage ?? "")
    }
}
