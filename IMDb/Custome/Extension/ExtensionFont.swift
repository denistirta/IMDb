//
//  ExtensionFont.swift
//  IMDb
//
//  Created by DenisTirta on 21/09/21.
//

import UIKit

extension UIFont{
    func convertFont(fontSize:CGFloat) -> UIFont{
        let currentFontName = self.fontName
        var calculatedFont: UIFont?
        let bounds = UIScreen.main.bounds
        let height = bounds.size.height
        switch height {
        case 480.0: //Iphone 3,4,SE => 3.5 inch
            calculatedFont = UIFont(name: currentFontName, size: fontSize * 0.8)
            return calculatedFont ?? UIFont()
        case 568.0: //iphone 5, 5s => 4 inch
            calculatedFont = UIFont(name: currentFontName, size: fontSize * 0.9)
            return calculatedFont ?? UIFont()
        case 667.0: //iphone 6, 6s => 4.7 inch
            calculatedFont = UIFont(name: currentFontName, size: self.pointSize)
            return calculatedFont ?? UIFont()
        case 736.0: //iphone 6s+ 6+ => 5.5 inch
            calculatedFont = UIFont(name: currentFontName, size: self.pointSize)
            return calculatedFont ?? UIFont()
        default:
            return self
        }
    }
    
}

