//
//  SectionItemCollectionViewCell.swift
//  Src
//
//  Created by BobaHasseb on 8/11/20.
//  Copyright © 2020 BobaHasseb. All rights reserved.
//

import UIKit

class SectionItemCollectionViewCell: UICollectionViewCell {
    // MARK: - Outlets
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var itemImage: UIImageView!
    // MARK: - Init
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    var itemCell: SectionsItem? {
        didSet {
            self.itemNameLabel.text = itemCell?.type
            guard let image = itemCell?.icon else {
                self.itemImage.image = UIImage(named: R.image.seller_image.name)
                return
            }
            let path = "http://hourse.highcoder.com/public/documents/website/"
            let imagePath = path + image
            self.itemImage.kf.setImage(with: URL(string: imagePath))
        }
    }
    var companyCell: CompanyListData? {
        didSet {
         self.itemNameLabel.text = companyCell?.name
         guard let image = companyCell?.logo else {
             self.itemImage.image = UIImage(named:
                 R.image.seller_image.name)
             return
         }
         let path = "http://hourse.highcoder.com/public/documents/website/"
         let imagePath = path + image
         self.itemImage.kf.setImage(with: URL(string: imagePath))
        }
    }
}
