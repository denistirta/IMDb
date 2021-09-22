//
//  DetailHeaderCell.swift
//  IMDb
//
//  Created by DenisTirta on 22/09/21.
//

import UIKit

@objc protocol DetailHeaderCellDelegate{
    @objc optional func actionVideo()
    @objc optional func actionPhotos()
}

class DetailHeaderCell: UITableViewCell {

    var delegate : DetailHeaderCellDelegate?
    @IBOutlet weak var valueYearHours: UILabelResize!
    @IBOutlet weak var TimeTrailer: UILabelResize!
    @IBOutlet weak var btnVideo: UIButtonResize!
    @IBOutlet weak var btnPhotos: UIButtonResize!
    @IBOutlet weak var valueBgImg: UIImageView!
    @IBOutlet weak var valueImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func pushVideo(_ sender: Any) {
        delegate?.actionVideo?()
    }
    
    @IBAction func pushPhotos(_ sender: Any) {
        delegate?.actionPhotos?()
    }
    
    
    
}
