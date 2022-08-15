//
//  PlayerTableViewCell.swift
//  UEFAMatch
//
//  Created by Ali Merhie on 8/13/22.
//

import UIKit

class PlayerTableViewCell: UITableViewCell {

    @IBOutlet weak var playerImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var holderView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setup(name: String, country: String, number: String, image: String){
        self.nameLabel.text = name
        self.countryLabel.text = country
        self.numberLabel.text = number
    }
    
}
