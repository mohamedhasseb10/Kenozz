//
//  LatestNewsCollectionViewCell.swift
//  Src
//
//  Created by BobaHasseb on 8/10/20.
//  Copyright © 2020 BobaHasseb. All rights reserved.
//

import UIKit

class LatestNewsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var newsDate: UILabel!
    @IBOutlet weak var newsImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    var itemCell: NewsItem? {
              didSet {
               self.newsTitle.text = itemCell?.title
              // self.newsDate.text = itemCell?.date
                guard let image = itemCell?.image else {
                    self.newsImage.image = UIImage(named:
                        R.image.news_horse.name)
                    return
                }
                if let path = itemCell?.path {
                   let imagePath = path + image
                   self.newsImage.kf.setImage(with: URL(string: imagePath))
                }
           }
       }
}
