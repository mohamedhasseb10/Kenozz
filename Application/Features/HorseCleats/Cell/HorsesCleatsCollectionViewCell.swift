//
//  HorsesCleatsCollectionViewCell.swift
//  Src
//
//  Created by BobaHasseb on 8/4/20.
//  Copyright © 2020 BobaHasseb. All rights reserved.
//

import UIKit

class HorsesCleatsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var horseCleatsImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    var itemCell: HorseCleatsData? {
           didSet {
            guard let image = itemCell?.logo else {
                self.horseCleatsImage.image = UIImage(named:
                    R.image.marabet_horse.name)
                return
            }
            if let path = itemCell?.path {
                let imagePath = path + image
                self.horseCleatsImage.kf.setImage(with: URL(string: imagePath))
            }
           }
    }
}
