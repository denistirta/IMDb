//
//  DetailHeaderView.swift
//  IMDb
//
//  Created by DenisTirta on 22/09/21.
//

import UIKit

@objc protocol DetailHeaderViewDelegate{
    @objc optional func actionBack()
}

class DetailHeaderView: UIView {

    var delegate: DetailHeaderViewDelegate?
    @IBOutlet weak var valueTitle: UILabelResize!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func pushBack(_ sender: Any) {
        delegate?.actionBack?()
    }

}
