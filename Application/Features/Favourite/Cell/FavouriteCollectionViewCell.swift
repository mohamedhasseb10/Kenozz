//
//  FavouriteCollectionViewCell.swift
//  Src
//
//  Created by BobaHasseb on 8/10/20.
//  Copyright © 2020 BobaHasseb. All rights reserved.
//

import UIKit

class FavouriteCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var favouriteImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    var itemCell: FavouriteItem? {
           didSet {
            self.nameLabel.text = itemCell?.name
            if let price = itemCell?.price {
                self.priceLabel.text = String(price)
            }
            guard let image = itemCell?.image else {
                self.favouriteImage.image = UIImage(named:
                    R.image.allproducts_image.name)
                return
            }
            self.favouriteImage.kf.setImage(with: URL(string: image))
           }
    }
    var productItemCell: ProductListItem? {
           didSet {
            self.nameLabel.text = productItemCell?.name
            if let price = productItemCell?.price {
                self.priceLabel.text = String(price)
            }
            guard let image = productItemCell?.image else {
                self.favouriteImage.image = UIImage(named:
                    R.image.allproducts_image.name)
                return
            }
            let path = "http://hourse.highcoder.com/public/documents/website/"
            let imagePath = path + image
            self.favouriteImage.kf.setImage(with: URL(string: imagePath))
           }
    }
}
