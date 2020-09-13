//
//  KenozTrollyViewController.swift
//  Src
//
//  Created by BobaHasseb on 8/1/20.
//  Copyright © 2020 BobaHasseb. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SellerViewController: UIViewController, BaseViewController {
    // MARK: - Outlets
    @IBOutlet weak var productCollectionView: UICollectionView!
    @IBOutlet weak var shopButton: UIButton!
    @IBOutlet weak var aboutSellerButton: UIButton!
    @IBOutlet weak var sellerInformationView: UIView!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var websiteLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    // MARK: - RxSwif Variables
    let disposeBag: DisposeBag = DisposeBag()
    let isSuccessproductCollectionView =
        PublishSubject<[CompanyProductItem]>()
    // MARK: - Variables
    let viewModel = SellerViewModel()
    var contentId = 0
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        regiserNibs()
        setUpCollectionView()
        setUpShopBindings()
        setUpAboutSellerBindings()
        setupCollectionViewBindings()
        bindCollectionViewSelected()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = false
        viewModel.getSellerProductData(idd: contentId)
    }
    // MARK: - RegisterNib
    func regiserNibs() {
        productCollectionView.registerNib(identifier:
            R.nib.allProductsCollectionViewCell.name)
    }
    // MARK: - SetUp CollectionViews
    func setUpCollectionView() {
        productCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
    }
    // MARK: - Bindings
    func setUpShopBindings() {
        viewModel.isLoadingShop
            .observeOn(MainScheduler.instance)
            .bind(to: self.rx.isAnimating)
            .disposed(by: disposeBag)
        viewModel
            .isErrorShop
            .observeOn(MainScheduler.instance)
            .bind(to: self.rx.isError)
            .disposed(by: disposeBag)

        viewModel
            .isSuccessShop.observeOn(MainScheduler.instance)
            .subscribe({ [weak self] (data) in
                guard let self = self else { return }
                guard let item = data.element else { return }
                if let listItems = item.data?.data {
                    self.isSuccessproductCollectionView.onNext(listItems)
                }
            }).disposed(by: disposeBag)
    }
    func setUpAboutSellerBindings() {
        viewModel.isLoadingAboutSeller
            .observeOn(MainScheduler.instance)
            .bind(to: self.rx.isAnimating)
            .disposed(by: disposeBag)
        viewModel
            .isErrorAboutSeller
            .observeOn(MainScheduler.instance)
            .bind(to: self.rx.isError)
            .disposed(by: disposeBag)

        viewModel
            .isSuccessAboutSeller.observeOn(MainScheduler.instance)
            .subscribe({ [weak self] (data) in
                guard let self = self else { return }
                guard let items = data.element else { return }
                if items.data?.count ?? 0 > 0 {
                    if let email = items.data?[0].email {
                        self.emailLabel.text = email
                    }
                    if let phoneNumber = items.data?[0].phone_contact {
                        self.phoneNumberLabel.text = phoneNumber
                    }
                    if let address = items.data?[0].address {
                        self.addressLabel.text = address
                    }
                    if let site = items.data?[0].site {
                        self.websiteLabel.text = site
                    }
                }
            }).disposed(by: disposeBag)
    }
    func setupCollectionViewBindings() {
        self.isSuccessproductCollectionView
            .observeOn(MainScheduler.instance)
            .bind(to: productCollectionView
                .rx
                .items(cellIdentifier: R.nib.allProductsCollectionViewCell.name,
                       cellType: AllProductsCollectionViewCell.self)) { (_, item, cell) in
                    cell.productCell = item
            }.disposed(by: disposeBag)
    }
    private func bindCollectionViewSelected() {
         Observable.zip(productCollectionView
                         .rx
                         .itemSelected, productCollectionView
                         .rx
                         .modelSelected(ProductItem.self)
                 )
                 .bind { [weak self] _, model in
                     guard let self = self else { return }
                     if let destinationVC =
                        ProductDetailsViewController.instantiateFromNib() {
                        destinationVC.contentId =  model.id ?? 0
                        destinationVC.name = model.name ?? ""
                        destinationVC.longDescription = model.description ?? ""
                        destinationVC.image = model.image ?? ""
                        if let price = model.price {
                            destinationVC.price = String(price)
                        }
                        self.navigationController?.pushViewController(destinationVC, animated: true)
                     }}.disposed(by: disposeBag)
    }
    // MARK: - Shop Events Pressed
    @IBAction func shopAction(_ sender: Any) {
        shopButton.backgroundColor =
            UIColor(red: 0.07, green: 0.51, blue: 0.72, alpha: 1.00)
        aboutSellerButton.backgroundColor = UIColor(red: 0.19, green: 0.19,
        blue: 0.19, alpha: 1.00)
        sellerInformationView.isHidden = true
        productCollectionView.isHidden = false
        viewModel.getSellerProductData(idd: contentId)
    }
    // MARK: - About Seller Pressed
    @IBAction func aboutSellerAction(_ sender: Any) {
        aboutSellerButton.backgroundColor =
            UIColor(red: 0.07, green: 0.51, blue: 0.72, alpha: 1.00)
        shopButton.backgroundColor = UIColor(red: 0.19, green: 0.19,
        blue: 0.19, alpha: 1.00)
        productCollectionView.isHidden = true
        sellerInformationView.isHidden = false
        viewModel.getAboutSellerData(idd: contentId)
    }
    // MARK: - Back Button Pressed
    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension SellerViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 88, height: 142)
    }
}
