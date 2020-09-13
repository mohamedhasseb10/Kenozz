//
//  PageControllerCollectionViewCell.swift
//  Src
//
//  Created by BobaHasseb on 8/1/20.
//  Copyright © 2020 BobaHasseb. All rights reserved.
//

import UIKit
import Kingfisher

class PageControllerCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var pageControllImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    var itemCell: KenozTrollySliderData? {
           didSet {
            guard let image = itemCell?.image else {
                self.pageControllImage.image = UIImage(named:
                    R.image.page_image.name)
                return
            }
            let path = "http://hourse.highcoder.com/public/documents/website/"
            let imagePath = path + image
            self.pageControllImage.kf.setImage(with: URL(string: imagePath))
           }
       }
    var kenozMagazineItemCell: KenozMagazineData? {
           didSet {
            guard let image = kenozMagazineItemCell?.image else {
                self.pageControllImage.image = UIImage(named:
                    R.image.page_image.name)
                return
            }
            if let path = kenozMagazineItemCell?.path {
               let imagePath = path + image
               self.pageControllImage.kf.setImage(with: URL(string: imagePath))
            }
           }
       }
    var cleatsDetailsItemCell: CleatsDetailsData? {
           didSet {
            guard let image = cleatsDetailsItemCell?.image else {
                self.pageControllImage.image = UIImage(named:
                    R.image.page_image.name)
                return
            }
            if let path = cleatsDetailsItemCell?.path {
               let imagePath = path + image
               self.pageControllImage.kf.setImage(with: URL(string: imagePath))
            }
        }
    }
}
