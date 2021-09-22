//
//  ListStyle3Cell.swift
//  IMDb
//
//  Created by DenisTirta on 22/09/21.
//

import UIKit

class ListStyle3Cell: UITableViewCell {

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
