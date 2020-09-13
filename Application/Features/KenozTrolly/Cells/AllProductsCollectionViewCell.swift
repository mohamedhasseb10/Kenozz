//
//  AllProductsCollectionViewCell.swift
//  Src
//
//  Created by BobaHasseb on 8/10/20.
//  Copyright © 2020 BobaHasseb. All rights reserved.
//

import UIKit

class AllProductsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    var itemCell: ProductItem? {
           didSet {
            self.nameLabel.text = itemCell?.name
            if let price = itemCell?.price {
               self.priceLabel.text = String(price)
            }
            guard let image = itemCell?.image else {
                self.productImage.image = UIImage(named:
                    R.image.allproducts_image.name)
                return
            }
            let path = "http://hourse.highcoder.com//documents/website/"
            let imagePath = path + image
            self.productImage.kf.setImage(with: URL(string: imagePath))
           }
    }
    var productCell: CompanyProductItem? {
           didSet {
            self.nameLabel.text = productCell?.name
            if let price = productCell?.price {
               self.priceLabel.text = String(price)
            }
            guard let image = productCell?.image else {
                self.productImage.image = UIImage(named:
                    R.image.allproducts_image.name)
                return
            }
            let path = "http://hourse.highcoder.com//documents/website/"
            let imagePath = path + image
            self.productImage.kf.setImage(with: URL(string: imagePath))
           }
    }
}
