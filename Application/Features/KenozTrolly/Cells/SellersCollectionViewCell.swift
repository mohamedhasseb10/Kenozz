//
//  SellersCollectionViewCell.swift
//  Src
//
//  Created by BobaHasseb on 8/2/20.
//  Copyright © 2020 BobaHasseb. All rights reserved.
//

import UIKit

class SellersCollectionViewCell: UICollectionViewCell {
    // MARK: - Outlets
    @IBOutlet weak var sellerNameLabel: UILabel!
    @IBOutlet weak var sellerImage: UIImageView!
    // MARK: - Init
    override func awakeFromNib() {
        super.awakeFromNib()
    }
        var itemCell: KenozTrollySellersListModelData? {
               didSet {
                self.sellerNameLabel.text = itemCell?.name
                guard let image = itemCell?.logo else {
                    self.sellerImage.image = UIImage(named:
                        R.image.page_image.name)
                    return
                }
                let path = "http://hourse.highcoder.com/public/documents/website/"
                let imagePath = path + image
                self.sellerImage.kf.setImage(with: URL(string: imagePath))
               }
           }
}
