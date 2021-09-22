//
//  ListStyle2Cell.swift
//  IMDb
//
//  Created by DenisTirta on 21/09/21.
//

import UIKit

class ListStyle2Cell: UITableViewCell {

    @IBOutlet weak var bgView: UIView!
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
