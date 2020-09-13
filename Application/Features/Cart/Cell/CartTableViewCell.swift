//
//  CartTableViewCell.swift
//  Src
//
//  Created by BobaHasseb on 8/13/20.
//  Copyright © 2020 BobaHasseb. All rights reserved.
//

import UIKit
import RxSwift

class CartTableViewCell: UITableViewCell {
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productNumber: UILabel!
    @IBOutlet weak var increaseQuantity: UIButton!
    @IBOutlet weak var decreaseQuantity: UIButton!
    var dispoedBag = DisposeBag()
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        dispoedBag = DisposeBag()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 5, right: 0))
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    var itemCell: CartItem? {
           didSet {
            self.productName.text = itemCell?.name
            if let price = itemCell?.price, let quantity = itemCell?.qty {
                self.productPrice.text = String(price)
                self.productNumber.text = String(quantity)
            }
       }
    }
    var orderItemCell: MyOrdersDetailsItem? {
           didSet {
            self.productName.text = orderItemCell?.name
            if let price = orderItemCell?.price, let quantity = orderItemCell?.qty {
                self.productPrice.text = String(price)
                self.productNumber.text = String(quantity)
            }
       }
    }
}
