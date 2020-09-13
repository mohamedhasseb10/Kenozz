//
//  ProductDetailsViewController.swift
//  Src
//
//  Created by BobaHasseb on 8/12/20.
//  Copyright © 2020 BobaHasseb. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Cosmos

class ProductDetailsViewController: UIViewController, BaseViewController {
    // MARK: - Outlets
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var yellowView: UIView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var reviewView: CosmosView!
    @IBOutlet weak var productTitleLabel: UILabel!
    @IBOutlet weak var productDateLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productDescriptionTextView: UITextView!
    @IBOutlet weak var likeButton: UIButton!
    // MARK: - RxSwif Variables
    let disposeBag: DisposeBag = DisposeBag()
    // MARK: - Variables
    let viewModel = ProductDetailsViewModel()
    var contentId = 0
    var categoryId = 0
    var price: String?
    var image: String?
    var name: String?
    var longDescription: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        setUpBindings()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
        showData()
        viewModel.getProductReview(with: contentId)
    }
    func setUpViews() {
        yellowView.roundCorners(radius: 12,
                                corners: [.layerMaxXMinYCorner,
                                          .layerMinXMinYCorner])
        mainView.roundCorners(radius: 12,
                                corners: [.layerMaxXMinYCorner,
                                          .layerMinXMinYCorner])
    }
    func showData() {
        if let price = price {
            productPriceLabel.text = price
        }
        if let name = name {
            productTitleLabel.text = name
        }
        if let description = longDescription {
            productDescriptionTextView.text = description
        }
        if let image = image {
            let path = "http://hourse.highcoder.com//documents/website/"
            let imagePath = path + image
            self.mainImage.kf.setImage(with: URL(string: imagePath))
        }
    }
    // MARK: - Bindings
    func setUpBindings() {
        viewModel.isLoading
            .observeOn(MainScheduler.instance)
            .bind(to: self.rx.isAnimating)
            .disposed(by: disposeBag)
        viewModel
            .isError
            .observeOn(MainScheduler.instance)
            .bind(to: self.rx.isError)
            .disposed(by: disposeBag)

        viewModel
            .isSuccess.observeOn(MainScheduler.instance)
            .subscribe({ [weak self] (_) in
                guard let self = self else { return }
                self.showAlert(title: "Success",
                               message: "Add product to cart successfully!")
            }).disposed(by: disposeBag)
        viewModel
            .isSuccessAddFavourite.observeOn(MainScheduler.instance)
            .subscribe({ [weak self] (_) in
                guard let self = self else { return }
                self.likeButton.setImage(UIImage(named:
                    R.image.favourite_img.name), for: .normal)
                self.showAlert(title: "Success",
                               message: "Add product to fav successfully!")
            }).disposed(by: disposeBag)
        viewModel
            .isSuccessGetProductReview.observeOn(MainScheduler.instance)
            .subscribe({ [weak self] (data) in
                guard let self = self else { return }
                guard let items = data.element else { return }
                if let data = items.data {
                    print(data)
                    if data.count > 0 {
                        if let rates = Double(data[0].rates ?? "0.0") {
                            print(rates)
                            self.reviewView.rating = rates
                        }
                    } else {
                        self.reviewView.rating = 0.0
                    }
                }
            }).disposed(by: disposeBag)
    }
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title,
        message: message,
        preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok",
        style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    // MARK: - Add To Cart Pressed
    @IBAction func addCartAction(_ sender: Any) {
        viewModel.addToCart(with: contentId, and: quantityLabel.text ?? "1")
    }
    // MARK: - Continue Shopping Pressed
    @IBAction func continueShopingAction(_ sender: Any) {
        let kenozTrolly = TabBarController.instantiate(fromAppStoryboard: .main)
        kenozTrolly.type = .kinozTrolley
        UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController = kenozTrolly
    }
    // MARK: - Increase Quantity Pressed
    @IBAction func increaseQuantityAction(_ sender: Any) {
        if let quantity = Int(quantityLabel.text!) {
            var quantityNumber = quantity
            quantityNumber += 1
            quantityLabel.text = String(quantityNumber)
        }
    }
    // MARK: - Decrease Quantity Pressed
    @IBAction func decreaseQuantityAction(_ sender: Any) {
        if let quantity = Int(quantityLabel.text!) {
            var quantityNumber = quantity
            if quantityNumber != 1 {
                quantityNumber -= 1
                quantityLabel.text = String(quantityNumber)
            }
        }
    }
    // MARK: - Add To Favourite Pressed
    @IBAction func addToFavouriteAction(_ sender: Any) {
        if !likeButton.isSelected {
            viewModel.addToFavourite(with: String(contentId))
        } else {
        }
        likeButton.isSelected = !likeButton.isSelected
    }
    // MARK: - Back Button Pressed
    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
