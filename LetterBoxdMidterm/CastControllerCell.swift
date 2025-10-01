//
//  CastControllerCell.swift
//  LetterBoxdMidterm
//
//  Created by Naila Amirova on 29.09.25.
//

import UIKit

class CastControllerCell: UITableViewCell {
    
    @IBOutlet weak private var castImage: UIImageView!
    @IBOutlet weak var castLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(image: String , text: String) {
        castImage.image = UIImage(named: image)
        castLabel.text = text
    }
    
}
