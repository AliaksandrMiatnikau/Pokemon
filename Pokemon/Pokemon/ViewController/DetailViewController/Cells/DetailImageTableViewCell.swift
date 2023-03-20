//
//  DetailImageTableViewCell.swift
//  Pokemon
//
//  Created by Aliaksandr Miatnikau on 20.03.23.
//

import UIKit

class DetailImageTableViewCell: UITableViewCell {
    
    // MARK: IBOutlets
    @IBOutlet weak var pokeImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
