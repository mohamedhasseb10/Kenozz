//
//  NewsDetailsViewController.swift
//  Src
//
//  Created by BobaHasseb on 8/11/20.
//  Copyright © 2020 BobaHasseb. All rights reserved.
//

import UIKit

class NewsDetailsViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var yellowView: UIView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var newsTitleLabel: UILabel!
    @IBOutlet weak var newsDateLabel: UILabel!
    @IBOutlet weak var newsDescriptionTextView: UITextView!
    @IBOutlet weak var likeButton: UIButton!
    // MARK: - Variables
    var newsItem = NewsItem()
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        showData()
    }
    func setUpViews() {
        yellowView.roundCorners(radius: 12,
                                corners: [.layerMaxXMinYCorner,
                                          .layerMinXMinYCorner])
        newsDescriptionTextView.roundCorners(radius: 12,
                                corners: [.layerMaxXMinYCorner,
                                          .layerMinXMinYCorner])
    }
    func showData() {
        newsTitleLabel.text = newsItem.title
        newsDescriptionTextView.text = newsItem.content
        guard let image = newsItem.image else {
            self.mainImage.image = UIImage(named:
                R.image.news_horse.name)
            return
        }
        if let path = newsItem.path {
           let imagePath = path + image
           self.mainImage.kf.setImage(with: URL(string: imagePath))
        }
    }
    // MARK: - Back Button Pressed
    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
