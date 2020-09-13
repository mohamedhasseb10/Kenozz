//
//  EventTableViewCell.swift
//  Src
//
//  Created by BobaHasseb on 8/4/20.
//  Copyright © 2020 BobaHasseb. All rights reserved.
//

import UIKit

class EventTableViewCell: UITableViewCell {
    @IBOutlet weak var dayName: UILabel!
    @IBOutlet weak var dayNumber: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var eventTitle: UILabel!
    @IBOutlet weak var eventImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0))
    }
    var itemCell: EventData? {
           didSet {
            if let dateString = itemCell?.event_date {
                print(dateString.getYear())
                let date = dateString.getDate()
                self.dayName.text = date?.getDayName()
                self.dayNumber.text = date?.getMonthNumber()
                let year = "\(date?.getMonthName() ?? "") \(dateString.getYear())"
                print(year)
                self.date.text = year
            }
            self.eventTitle.text = itemCell?.name
            guard let image = itemCell?.image else {
                self.eventImage.image = UIImage(named:
                    R.image.event.name)
                return
            }
            if let path = itemCell?.path {
               let imagePath = path + image
               self.eventImage.kf.setImage(with: URL(string: imagePath))
               self.eventImage.image = UIImage(named:
                   R.image.event.name)
            }
           }
       }
    var championCell: ChampionItem? {
           didSet {
            if let dateString = championCell?.date {
                print(dateString.getYear())
                let date = dateString.getDate()
                self.dayName.text = date?.getDayName()
                self.dayNumber.text = date?.getMonthNumber()
                let year = "\(date?.getMonthName() ?? "") \(dateString.getYear())"
                print(year)
                self.date.text = year
            }
            self.eventTitle.text = championCell?.description
            guard let image = championCell?.image else {
                self.eventImage.image = UIImage(named:
                    R.image.event.name)
                return
            }
            if let path = championCell?.path {
               let imagePath = path + image
               self.eventImage.kf.setImage(with: URL(string: imagePath))
               self.eventImage.image = UIImage(named:
                   R.image.horsePhoto.name)
            }
           }
       }
}
