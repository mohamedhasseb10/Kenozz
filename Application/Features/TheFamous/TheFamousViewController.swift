//
//  TheFamousViewController.swift
//  Src
//
//  Created by BobaHasseb on 8/10/20.
//  Copyright © 2020 BobaHasseb. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class TheFamousViewController: UIViewController, BaseViewController {
    // MARK: - Outlets
    @IBOutlet weak var productCollectionView: UICollectionView!
    @IBOutlet weak var followingLabel: UILabel!
    @IBOutlet weak var followersLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    // MARK: - RxSwif Variables
    let disposeBag: DisposeBag = DisposeBag()
    let isSuccessProductCollectionView = PublishSubject<[ProductListItem]>()
    // MARK: - Variables
    let viewModel = TheFamousViewModel()
    var contentId = 0
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
        viewModel.getProductListData(idd: contentId)
    }
    // MARK: - RegisterNib
    func regiserNibs() {
        productCollectionView.registerNib(identifier:
            R.nib.theFamousCollectionViewCell.name)
    }
    // MARK: - SetUp CollectionViews
    func setUpCollectionView() {
        productCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
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
                    self.isSuccessProductCollectionView.onNext(products)
                }
            }).disposed(by: disposeBag)
    }
    func setupCollectionViewBindings() {
        self.isSuccessProductCollectionView
            .observeOn(MainScheduler.instance)
            .bind(to: productCollectionView
                .rx
                .items(cellIdentifier: R.nib.theFamousCollectionViewCell.name,
                       cellType: TheFamousCollectionViewCell.self)) { (_, item, cell) in
                   cell.itemCell = item
            }.disposed(by: disposeBag)
    }
    func setUpCollectionViewSelected() {
        Observable
                .zip(
                    productCollectionView
                        .rx
                        .itemSelected, productCollectionView
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
                        print("ewee")
                        print(model.image ?? "")
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
extension TheFamousViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:
            (productCollectionView.frame.width - 30) / 3.0, height: 145)
    }
}
