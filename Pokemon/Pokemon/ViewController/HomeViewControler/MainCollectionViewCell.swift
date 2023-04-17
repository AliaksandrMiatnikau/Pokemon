//
//  MainCollectionViewCell.swift
//  Pokemon
//
//  Created by Aliaksandr Miatnikau on 20.03.23.
//

import UIKit

final class MainCollectionViewCell: UICollectionViewCell {
   
   
    let shadowRadius: CGFloat = 2
    let shadowOpacity: Float = 0.25
    let cornerRadius: CGFloat = 6
    let shadowOffsetWidth: CGFloat = 0
    let shadowOffsetHeight: CGFloat = 1
  
    
    // MARK: IBOutlets
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var pokeImageView: UIImageView!
    @IBOutlet weak var pokeName: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.cardView.layer.cornerRadius = cornerRadius
        self.cardView.layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight)
        self.cardView.layer.shadowRadius = shadowRadius
        self.cardView.layer.shadowOpacity = shadowOpacity
        self.cardView.layer.shadowPath = UIBezierPath(roundedRect: self.cardView.frame, cornerRadius: cornerRadius).cgPath
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.pokeImageView.image = nil
    }
}


