//
//  MyOrdersListTableViewCell.swift
//  Src
//
//  Created by BobaHasseb on 8/20/20.
//  Copyright © 2020 BobaHasseb. All rights reserved.
//

import UIKit
import RxSwift

class MyOrdersListTableViewCell: UITableViewCell {
    @IBOutlet weak var orderNumber: UILabel!
    @IBOutlet weak var orderStatus: UILabel!
    @IBOutlet weak var orderCost: UILabel!
    @IBOutlet weak var orderDetailsButton: UIButton!
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

        // Configure the view for the selected state
    }
    var itemCell: MyOrdersListItem? {
           didSet {
            if let orderNumber = itemCell?.id {
                self.orderNumber.text = String(orderNumber)
            }
            if let orderAmount = itemCell?.total, let concurancy =
                itemCell?.currency {
                self.orderCost.text = String(orderAmount) + concurancy
            }
            self.orderStatus.text = itemCell?.order_status?.name
           }
       }
}
