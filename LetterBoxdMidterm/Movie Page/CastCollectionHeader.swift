//
//  CastCollectionHeader.swift
//  LetterBoxdMidterm
//
//  Created by Naila Amirova on 21.09.25.
//

import UIKit

class CastCollectionHeader: UICollectionReusableView {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var seeAllButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.text = "Cast"
        titleLabel.font = .boldSystemFont(ofSize: 23)
        titleLabel.textColor = .white

        seeAllButton.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        seeAllButton.tintColor = .white
    }
    
}
