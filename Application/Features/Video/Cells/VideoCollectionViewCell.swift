//
//  VideoCollectionViewCell.swift
//  Src
//
//  Created by BobaHasseb on 8/3/20.
//  Copyright © 2020 BobaHasseb. All rights reserved.
//

import UIKit

class VideoCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var videoImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    var itemCell: VideoItem? {
           didSet {
            guard let image = itemCell?.image else {
                self.videoImage.image = UIImage(named:
                    R.image.video_horse.name)
                return
            }
            if let path = itemCell?.path {
                let imagePath = path + image
                self.videoImage.kf.setImage(with: URL(string: imagePath))
            }
           }
    }
}
