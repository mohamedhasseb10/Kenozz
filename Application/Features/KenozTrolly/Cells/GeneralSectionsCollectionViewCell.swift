//
//  GeneralSectionsCollectionViewCell.swift
//  Src
//
//  Created by BobaHasseb on 9/6/20.
//  Copyright © 2020 BobaHasseb. All rights reserved.
//

import UIKit

class GeneralSectionsCollectionViewCell: UICollectionViewCell {
    // MARK: - Outlets
    @IBOutlet weak var sectionNameLabel: UILabel!
    @IBOutlet weak var sectionImage: UIImageView!
    // MARK: - Init
    override func awakeFromNib() {
        super.awakeFromNib()
    }
        var itemCell: GeneralSectionsData? {
               didSet {
                self.sectionNameLabel.text = itemCell?.type
                guard let image = itemCell?.icon else {
                    self.sectionImage.image = UIImage(named:
                        R.image.seller_image.name)
                    return
                }
                let path = "http://hourse.highcoder.com/public/documents/website/"
                let imagePath = path + image
                self.sectionImage.kf.setImage(with: URL(string: imagePath))
               }
           }
}
