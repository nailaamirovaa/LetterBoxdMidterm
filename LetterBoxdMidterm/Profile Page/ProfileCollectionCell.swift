//
//  ProfileCollectionCell.swift
//  LetterBoxdMidterm
//
//  Created by Naila Amirova on 25.09.25.
//

import UIKit

class ProfileCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var collectionImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        collectionImage.image = ._12AngryMen
    }
    
    func configureCell(image : String) {
        collectionImage.image = UIImage(named: image)
    }

}
