//
//  SearchCell.swift
//  LetterBoxdMidterm
//
//  Created by Naila Amirova on 22.09.25.
//

import UIKit

class SearchCell: UICollectionViewCell {

    @IBOutlet private weak var cellImage: UIImageView!
    @IBOutlet private weak var cellLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    var callBack : ((String) -> Void)?
    
    func configureSearchCell(image : String , label : String) {
        callBack?(label)
        cellLabel.text = label
        cellImage.image = UIImage(named: image)
    }

}
