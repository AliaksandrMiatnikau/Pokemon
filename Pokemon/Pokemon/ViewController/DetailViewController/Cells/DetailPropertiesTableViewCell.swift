//
//  DetailPropertiesTableViewCell.swift
//  Pokemon
//
//  Created by Aliaksandr Miatnikau on 20.03.23.
//

import UIKit

final class DetailPropertiesTableViewCell: UITableViewCell {

    // MARK: IBOutlets
    @IBOutlet weak var labelHeight: UILabel!
    @IBOutlet weak var labelWeight: UILabel!
    @IBOutlet weak var labelSpecies: UILabel!
    @IBOutlet weak var labelType: UILabel!
    @IBOutlet weak var labelAbility: UILabel!
    @IBOutlet weak var labelNumber: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
