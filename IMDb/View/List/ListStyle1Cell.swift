//
//  ListStyle1Cell.swift
//  IMDb
//
//  Created by DenisTirta on 21/09/21.
//

import UIKit

class ListStyle1Cell: UICollectionViewCell {

    @IBOutlet weak var imgMovie: UIImageView!
    @IBOutlet weak var imgRating: UIImageView!
    
    @IBOutlet weak var valueYear: UILabelResize!
    @IBOutlet weak var valueRating: UILabelResize!
    
    @IBOutlet weak var nameMovie: UILabelResize!
    @IBOutlet weak var valueCrew: UILabelResize!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
