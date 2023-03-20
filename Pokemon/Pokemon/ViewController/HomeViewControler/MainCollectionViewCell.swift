//
//  MainCollectionViewCell.swift
//  Pokemon
//
//  Created by Aliaksandr Miatnikau on 20.03.23.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var bgCardView: UIView!
    @IBOutlet weak var pokeImageView: UIImageView!
    @IBOutlet weak var pokeId: UILabel!
    @IBOutlet weak var pokeName: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let cornerRadius: CGFloat = 6
        
        self.bgCardView.layer.cornerRadius = cornerRadius
        
//        self.bgCardView.layer.shadowColor = UIColor(white: , alpha: 1).cgColor
        self.bgCardView.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.bgCardView.layer.shadowRadius = 2
        self.bgCardView.layer.shadowOpacity = 0.25
        self.bgCardView.layer.shadowPath = UIBezierPath(roundedRect: self.bgCardView.frame, cornerRadius: cornerRadius).cgPath
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.pokeImageView.image = nil
    }
}


