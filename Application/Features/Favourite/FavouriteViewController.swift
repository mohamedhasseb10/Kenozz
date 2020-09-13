//
//  FavouriteViewController.swift
//  Src
//
//  Created by BobaHasseb on 8/10/20.
//  Copyright © 2020 BobaHasseb. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class FavouriteViewController: UIViewController, BaseViewController {
    // MARK: - Outlets
    @IBOutlet weak var favouriteCollectionView: UICollectionView!
    // MARK: - RxSwif Variables
    let disposeBag: DisposeBag = DisposeBag()
    let isSuccessFavouriteCollectionView = PublishSubject<[FavouriteItem]>()
    // MARK: - Variables
    let viewModel = FavouriteViewModel()
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
        viewModel.getFavouriteData()
    }
    // MARK: - RegisterNib
    func regiserNibs() {
        favouriteCollectionView.registerNib(identifier:
            R.nib.favouriteCollectionViewCell.name)
    }
    // MARK: - SetUp CollectionViews
    func setUpCollectionView() {
        favouriteCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
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
                if let favourites = items.data?.items {
                    self.isSuccessFavouriteCollectionView.onNext(favourites)
                }
            }).disposed(by: disposeBag)
    }
    func setupCollectionViewBindings() {
        self.isSuccessFavouriteCollectionView
            .observeOn(MainScheduler.instance)
            .bind(to: favouriteCollectionView
                .rx
                .items(cellIdentifier: R.nib.favouriteCollectionViewCell.name,
                       cellType: FavouriteCollectionViewCell.self)) { (_, item, cell) in
                   cell.itemCell = item
            }.disposed(by: disposeBag)
    }
    func setUpCollectionViewSelected() {
        Observable
                .zip(
                    favouriteCollectionView
                        .rx
                        .itemSelected, favouriteCollectionView
                        .rx
                        .modelSelected(FavouriteItem.self)
                )
                .bind { [weak self] _, model in
                    guard let self = self else { return }
                    if let destinationVC =
                       ProductDetailsViewController.instantiateFromNib() {
                        if let idd = model.id {
                            destinationVC.contentId = Int(idd) ?? 0
                        }
                        destinationVC.name = model.name ?? ""
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
extension FavouriteViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:
            (favouriteCollectionView.frame.width - 30) / 3.0, height: 145)
    }
}
