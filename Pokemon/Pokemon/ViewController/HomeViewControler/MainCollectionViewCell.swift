//
//  MainCollectionViewCell.swift
//  Pokemon
//
//  Created by Aliaksandr Miatnikau on 20.03.23.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {
   
    // MARK: IBOutlets
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var pokeImageView: UIImageView!
    @IBOutlet weak var pokeName: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let cornerRadius: CGFloat = 6
        
        self.cardView.layer.cornerRadius = cornerRadius
        self.cardView.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.cardView.layer.shadowRadius = 2
        self.cardView.layer.shadowOpacity = 0.25
        self.cardView.layer.shadowPath = UIBezierPath(roundedRect: self.cardView.frame, cornerRadius: cornerRadius).cgPath
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.pokeImageView.image = nil
    }
}


