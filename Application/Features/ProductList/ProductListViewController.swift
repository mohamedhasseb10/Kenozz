//
//  ProductListViewController.swift
//  Src
//
//  Created by BobaHasseb on 8/17/20.
//  Copyright © 2020 BobaHasseb. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ProductListViewController: UIViewController, BaseViewController {
    // MARK: - Outlets
    @IBOutlet weak var productListCollectionView: UICollectionView!
    // MARK: - RxSwif Variables
    let disposeBag: DisposeBag = DisposeBag()
    let isSuccessproductListCollectionView = PublishSubject<[ProductListItem]>()
    // MARK: - Variables
    let viewModel = ProductListViewModel()
    var contentId = 0
    var categoryId = 0
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        regiserNibs()
        setUpCollectionView()
        setUpBindings()
        setupCollectionViewBindings()
        setUpCollectionViewSelected()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        viewModel.getProductListData(idd: contentId, categoryId: categoryId)
    }
    // MARK: - RegisterNib
    func regiserNibs() {
        productListCollectionView.registerNib(identifier:
            R.nib.favouriteCollectionViewCell.name)
    }
    // MARK: - SetUp CollectionViews
    func setUpCollectionView() {
        productListCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
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
            .subscribe({ [weak self] (data) in
                guard let self = self else { return }
                guard let items = data.element else { return }
                if let products = items.data?.data {
                    self.isSuccessproductListCollectionView.onNext(products)
                }
            }).disposed(by: disposeBag)
    }
    func setupCollectionViewBindings() {
        self.isSuccessproductListCollectionView
            .observeOn(MainScheduler.instance)
            .bind(to: productListCollectionView
                .rx
                .items(cellIdentifier: R.nib.favouriteCollectionViewCell.name,
                       cellType: FavouriteCollectionViewCell.self)) { (_, item, cell) in
                   cell.productItemCell = item
            }.disposed(by: disposeBag)
    }
    func setUpCollectionViewSelected() {
        Observable
                .zip(
                    productListCollectionView
                        .rx
                        .itemSelected, productListCollectionView
                        .rx
                        .modelSelected(ProductListItem.self)
                )
                .bind { [weak self] _, model in
                    guard let self = self else { return }
                    if let destinationVC =
                       ProductDetailsViewController.instantiateFromNib() {
                        destinationVC.contentId =  model.id ?? 0
                        destinationVC.categoryId = model.category_id ?? 0
                        destinationVC.name = model.name ?? ""
                        destinationVC.longDescription = model.description ?? ""
                        destinationVC.image = model.image ?? ""
                        if let price = model.price {
                            destinationVC.price = String(price)
                        }
                       self.navigationController?.pushViewController(destinationVC, animated: true)
                    }}.disposed(by: disposeBag)
    }
    // MARK: - Back Button Pressed
    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
extension ProductListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:
            (productListCollectionView.frame.width - 30) / 3.0, height: 145)
    }
}
