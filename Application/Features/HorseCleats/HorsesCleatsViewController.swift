//
//  HorsesCleatsViewController.swift
//  Src
//
//  Created by BobaHasseb on 8/4/20.
//  Copyright © 2020 BobaHasseb. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class HorsesCleatsViewController: UIViewController, BaseViewController {
    // MARK: - Outlets
    @IBOutlet weak var horseCleatsCollectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    // MARK: - RxSwif Variables
    let disposeBag: DisposeBag = DisposeBag()
    let isSuccessHorseCleatsCollectionView =
        PublishSubject<[HorseCleatsData]>()
    // MARK: - Variables
    let viewModel = HorseCleatsViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        regiserNibs()
        setUpCollectionView()
        setUpBindings()
        setupCollectionViewBindings()
        bindCollectionViewSelected()
        self.searchBar.resignFirstResponder()
    }
    override func viewWillAppear(_ animated: Bool) {
        viewModel.getHorseCleatsData()
        self.searchBar.resignFirstResponder()
    }
    // MARK: - RegisterNib
    func regiserNibs() {
        horseCleatsCollectionView.registerNib(identifier:
            R.nib.horsesCleatsCollectionViewCell.name)
    }
    // MARK: - SetUp CollectionViews
    func setUpCollectionView() {
        horseCleatsCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
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
                if let cleats = items.data {
                    self.isSuccessHorseCleatsCollectionView.onNext(cleats)
                }
            }).disposed(by: disposeBag)
    }
    func setupCollectionViewBindings() {
        self.isSuccessHorseCleatsCollectionView
            .observeOn(MainScheduler.instance)
            .bind(to: horseCleatsCollectionView
                .rx
                .items(cellIdentifier: R.nib.horsesCleatsCollectionViewCell.name,
                       cellType: HorsesCleatsCollectionViewCell.self)) { (_, item, cell) in
                   cell.itemCell = item
            }.disposed(by: disposeBag)
    }
    private func bindCollectionViewSelected() {
         Observable
                 .zip(
                     horseCleatsCollectionView
                         .rx
                         .itemSelected, horseCleatsCollectionView
                         .rx
                         .modelSelected(HorseCleatsData.self)
                 )
                 .bind { [weak self] _, model in
                     guard let self = self else { return }
                     if let destinationVC =
                        CleatsDetailsViewController.instantiateFromNib() {
                        destinationVC.contentId =  model.id ?? 0
                        self.navigationController?.pushViewController(destinationVC, animated: true)
                     }}.disposed(by: disposeBag)
    }
}
extension HorsesCleatsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (horseCleatsCollectionView.frame.width - 30) / 3.0,
                      height: 78)

    }
}
