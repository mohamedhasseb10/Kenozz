//
//  PhotosListTableViewCell.swift
//  Src
//
//  Created by BobaHasseb on 9/8/20.
//  Copyright © 2020 BobaHasseb. All rights reserved.
//

import UIKit

class PhotosListTableViewCell: UITableViewCell {
    @IBOutlet weak var photoTitle: UILabel!
    @IBOutlet weak var photoImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 2, right: 0))
    }
    var itemCell: CompanyProductItem? {
           didSet {
            self.photoTitle.text = itemCell?.name
             guard let image = itemCell?.image else {
                 self.photoImage.image = UIImage(named:
                     R.image.horsePhoto.name)
                 return
             }
            let path = "http://hourse.highcoder.com/public/documents/website/"
            let imagePath = path + image
            self.photoImage.kf.setImage(with: URL(string: imagePath))
        }
    }
}
