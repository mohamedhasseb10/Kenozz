//
//  NewsTableViewCell.swift
//  Src
//
//  Created by BobaHasseb on 8/4/20.
//  Copyright © 2020 BobaHasseb. All rights reserved.
//

import UIKit
import Kingfisher

class NewsTableViewCell: UITableViewCell {
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var newsDate: UILabel!
    @IBOutlet weak var newsImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 5, right: 0))
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
