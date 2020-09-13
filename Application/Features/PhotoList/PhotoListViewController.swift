//
//  PhotoListViewController.swift
//  Src
//
//  Created by BobaHasseb on 9/7/20.
//  Copyright © 2020 BobaHasseb. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class PhotoListViewController: UIViewController, BaseViewController {
    // MARK: - Outlets
    @IBOutlet weak var photosTableView: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    // MARK: - RxSwif Variables
    let disposeBag: DisposeBag = DisposeBag()
    let isSuccessTableView = PublishSubject<[CompanyProductItem]>()
    // MARK: - Variables
    let viewModel = PhotosListViewModel()
    var contentId = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        regiserNibs()
        setUpBindings()
        setupTableViewBindings()
       // bindTableViewSelected()
    }
    override func viewWillAppear(_ animated: Bool) {
        print(contentId)
        viewModel.getPhotosData(idd: contentId)
        photosTableView.rowHeight = 165
    }
    // MARK: - RegisterNib
    func regiserNibs() {
        photosTableView.registerNib(identifier: R.nib.photosListTableViewCell.name)
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
                if let photos = items.data?.data {
                    self.isSuccessTableView.onNext(photos)
                }
            }).disposed(by: disposeBag)
    }
    func setupTableViewBindings() {
        self.isSuccessTableView
            .observeOn(MainScheduler.instance)
            .bind(to: photosTableView
                .rx
                .items(cellIdentifier: R.nib.photosListTableViewCell.name,
                       cellType: PhotosListTableViewCell.self)) { (_, item, cell) in
                   cell.itemCell = item
            }.disposed(by: disposeBag)
    }
//    private func bindTableViewSelected() {
//         Observable
//                 .zip(
//                     photosTableView
//                         .rx
//                         .itemSelected, photosTableView
//                         .rx
//                         .modelSelected(PhotoListData.self)
//                 )
//                 .bind { [weak self] _, model in
//                     guard let self = self else { return }
//                     if let destinationVC =
//                        NewsDetailsViewController.instantiateFromNib() {
//                        destinationVC.newsItem =  model
//                        self.navigationController?.pushViewController(destinationVC, animated: true)
//                     }}.disposed(by: disposeBag)
//    }
}
