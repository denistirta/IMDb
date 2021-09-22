//
//  CollectionListCell.swift
//  IMDb
//
//  Created by DenisTirta on 21/09/21.
//

import UIKit
import SDWebImage
import CHTCollectionViewWaterfallLayout
import SwiftyJSON

@objc protocol CollectionListCellDelegate{
    @objc optional func actionDetail(index: Int)
}

class CollectionListCell: UITableViewCell {

    var delegate: CollectionListCellDelegate?
    @IBOutlet weak var collectionList: UICollectionView!
    @IBOutlet weak var aspect: NSLayoutConstraint!
    
    var aspectRation = NSLayoutConstraint()
    
    var list: [TopMovies]?
    var width = CGFloat()
    var count = Int()
        
    var collectionHeight: CGFloat {
        collectionList.reloadData()
        collectionList.layoutIfNeeded()
        return collectionList.contentSize.height
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionList.delegate = self
        collectionList.dataSource = self
        collectionList.backgroundColor = UIColor.clear
        collectionList.register(UINib(nibName: ListStyle1Cell.className, bundle: nil), forCellWithReuseIdentifier: ListStyle1Cell.className)

        self.width = self.collectionList.bounds.width
    }
        
    func setupColletion(){
        self.collectionList.tag = 1
        self.collectionList.reloadData()
                
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.estimatedItemSize = CGSize(width: 140, height: 300)
        flowLayout.minimumInteritemSpacing = 16
        flowLayout.minimumLineSpacing = 16
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 16, right: 16)
        
        aspectRation = NSLayoutConstraint(item: self.collectionList as Any,
                                          attribute: NSLayoutConstraint.Attribute.height,
                                          relatedBy: NSLayoutConstraint.Relation.equal,
                                          toItem: self.collectionList!,
                                          attribute: NSLayoutConstraint.Attribute.width,
                                          multiplier: 300 / self.width,
                                          constant: 0)
        
        let newConstraint = aspectRation
        self.collectionList.removeConstraint(aspect)
        self.collectionList.addConstraint(newConstraint)
        self.collectionList.layoutIfNeeded()
        aspect = newConstraint
        
        self.collectionList.showsVerticalScrollIndicator = false
        self.collectionList.showsHorizontalScrollIndicator = false
        self.collectionList.collectionViewLayout = flowLayout
        self.collectionList.isScrollEnabled = true
        
        self.collectionList.collectionViewLayout.invalidateLayout()
    }

    func setupColletion2(){
        self.collectionList.tag = 2
        self.collectionList.reloadData()
        
        let flowLayout = CHTCollectionViewWaterfallLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        flowLayout.minimumColumnSpacing = 16
        flowLayout.minimumInteritemSpacing = 16
        flowLayout.columnCount = 2
        collectionList.collectionViewLayout = flowLayout
        
        self.collectionList.collectionViewLayout = flowLayout
        self.collectionList.isScrollEnabled = false
                        
        aspectRation = NSLayoutConstraint(item: self.collectionList as Any,
                                          attribute: NSLayoutConstraint.Attribute.height,
                                          relatedBy: NSLayoutConstraint.Relation.equal,
                                          toItem: self.collectionList!,
                                          attribute: NSLayoutConstraint.Attribute.width,
                                          multiplier: collectionHeight / self.width,
                                          constant: 0)
        let newConstraint = aspectRation
        self.collectionList.removeConstraint(aspect)
        self.collectionList.addConstraint(newConstraint)
        self.collectionList.layoutIfNeeded()
        aspect = newConstraint

        self.collectionList.collectionViewLayout.invalidateLayout()
    }

    
}

extension CollectionListCell: UICollectionViewDelegate, UICollectionViewDataSource, CHTCollectionViewDelegateWaterfallLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView.tag {
        case 1:
            return CGSize(width: 140, height: 300)
        case 2:
            return CGSize(width: 140, height: 260)
        default:
            return CGSize.zero
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView.tag {
        case 1:
            return 10
        case 2:
            return count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView.tag {
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListStyle1Cell.className, for: indexPath) as! ListStyle1Cell

            cell.imgMovie?.sd_imageIndicator = SDWebImageActivityIndicator.whiteLarge
            cell.imgMovie.sd_setImage(with: URL(string: self.list?[indexPath.row].image ?? ""), placeholderImage: UIImage(named: "Default"))

            cell.valueRating.text = self.list?[indexPath.row].imDBRating ?? ""
            cell.valueYear.text = self.list?[indexPath.row].year ?? ""
            cell.nameMovie.text = self.list?[indexPath.row].title ?? ""
            cell.valueCrew.text = self.list?[indexPath.row].crew ?? ""
                    
            cell.layer.borderColor = UIColor.white.cgColor
            cell.layer.borderWidth = 1
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListStyle1Cell.className, for: indexPath) as! ListStyle1Cell
            
            cell.imgMovie?.sd_imageIndicator = SDWebImageActivityIndicator.whiteLarge
            cell.imgMovie.sd_setImage(with: URL(string: self.list?[indexPath.row+20].image ?? ""), placeholderImage: UIImage(named: "Default"))

            cell.valueRating.text = self.list?[indexPath.row+20].imDBRating ?? ""
            cell.valueYear.text = self.list?[indexPath.row+20].year ?? ""
            cell.nameMovie.text = self.list?[indexPath.row+20].title ?? ""
            cell.valueCrew.text = self.list?[indexPath.row+20].crew ?? ""
                    
            cell.layer.borderColor = UIColor.white.cgColor
            cell.layer.borderWidth = 1
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView.tag {
        case 1:
            delegate?.actionDetail?(index: indexPath.row)
        case 2:
            delegate?.actionDetail?(index: indexPath.row+20)
        default:
            break
        }
    }
}

