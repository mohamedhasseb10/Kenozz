//
//  VideoViewController.swift
//  Src
//
//  Created by BobaHasseb on 8/3/20.
//  Copyright © 2020 BobaHasseb. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class VideoViewController: UIViewController, BaseViewController {
    // MARK: - Outlets
    @IBOutlet weak var videoCollectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    // MARK: - RxSwif Variables
    let disposeBag: DisposeBag = DisposeBag()
    let isSuccessVideoCollectionView = PublishSubject<[VideoItem]>()
    // MARK: - Variables
    let viewModel = VideoViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        regiserNibs()
        setUpCollectionView()
        setUpBindings()
        setupCollectionViewBindings()
        bindCollectionViewSelected()
        viewModel.getVideoData()
        self.searchBar.resignFirstResponder()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.searchBar.resignFirstResponder()
    }
    // MARK: - RegisterNib
    func regiserNibs() {
        videoCollectionView.registerNib(identifier: R.nib.videoCollectionViewCell.name)
    }
    // MARK: - SetUp CollectionViews
    func setUpCollectionView() {
        videoCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
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
                if let videos = items.data?.data {
                    self.isSuccessVideoCollectionView.onNext(videos)
                }
            }).disposed(by: disposeBag)
    }
    func setupCollectionViewBindings() {
        self.isSuccessVideoCollectionView
            .observeOn(MainScheduler.instance)
            .bind(to: videoCollectionView
                .rx
                .items(cellIdentifier: R.nib.videoCollectionViewCell.name,
                       cellType: VideoCollectionViewCell.self)) { (_, item, cell) in
                   cell.itemCell = item
            }.disposed(by: disposeBag)
    }
    private func bindCollectionViewSelected() {
         Observable
                 .zip(
                     videoCollectionView
                         .rx
                         .itemSelected, videoCollectionView
                         .rx
                         .modelSelected(VideoItem.self)
                 )
                 .bind { [weak self] _, model in
                    guard self != nil else { return }
                    guard let url = model.url else {
                        return
                    }
                    guard let link = URL(string: url) else {
                        return
                    }
                    UIApplication.shared.open(link)
                     }.disposed(by: disposeBag)
    }
}
extension VideoViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (videoCollectionView.frame.width - 25) / 3.0, height: 80)

    }
}
