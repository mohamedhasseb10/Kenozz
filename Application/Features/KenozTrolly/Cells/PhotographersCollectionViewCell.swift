//
//  PhotographersCollectionViewCell.swift
//  Src
//
//  Created by BobaHasseb on 9/7/20.
//  Copyright © 2020 BobaHasseb. All rights reserved.
//

import UIKit

class PhotographersCollectionViewCell: UICollectionViewCell {
    // MARK: - Outlets
    @IBOutlet weak var photoGrapherNameLabel: UILabel!
    @IBOutlet weak var photoGrapherImage: UIImageView!
    // MARK: - Init
    override func awakeFromNib() {
        super.awakeFromNib()
    }
        var itemCell: PhotoGrapherItem? {
               didSet {
                self.photoGrapherNameLabel.text = itemCell?.name
                guard let image = itemCell?.image else {
                    self.photoGrapherImage.image = UIImage(named:
                        R.image.seller_image.name)
                    return
                }
                let path = "http://hourse.highcoder.com/public/documents/website/"
                let imagePath = path + image
                self.photoGrapherImage.kf.setImage(with: URL(string: imagePath))
               }
           }

}
