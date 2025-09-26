//
//  InnerHomwCollectionCell.swift
//  LetterBoxdMidterm
//
//  Created by Naila Amirova on 17.09.25.
//

import UIKit

class InnerHomwCollectionCell: UICollectionViewCell {

    @IBOutlet weak var innerCellImage: UIImageView!
    
    func configureInnerCell(image : String) {
        innerCellImage.image = UIImage(named: image)
        innerCellImage.layer.cornerRadius = 10
    }

}
