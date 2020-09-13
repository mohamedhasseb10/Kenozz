//
//  PhotoLibraryCollectionViewCell.swift
//  Src
//
//  Created by BobaHasseb on 8/11/20.
//  Copyright © 2020 BobaHasseb. All rights reserved.
//

import UIKit

class PhotoLibraryCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var photoLibraryImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    var itemCell: CleatsDetailsData? {
           didSet {
            guard let image = itemCell?.image else {
                self.photoLibraryImage.image = UIImage(named:
                    R.image.video_horse.name)
                return
            }
            if let path = itemCell?.path {
               let imagePath = path + image
               self.photoLibraryImage.kf.setImage(with: URL(string: imagePath))
            }
        }
    }
}
