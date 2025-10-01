//
//  CastCell.swift
//  LetterBoxdMidterm
//
//  Created by Naila Amirova on 21.09.25.
//

import UIKit

class CastCell: UICollectionViewCell {

    @IBOutlet private weak var actorImage: UIImageView!
    @IBOutlet private weak var actorNameLabel: UILabel!
    @IBOutlet private weak var actorRoleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCastCell(image: String , name: String , role: String) {
        actorImage.image = UIImage(named: image)
        actorNameLabel.text = name
        actorRoleLabel.text = role
    }
}
