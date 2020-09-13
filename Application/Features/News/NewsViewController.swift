//
//  NewsViewController.swift
//  Src
//
//  Created by BobaHasseb on 8/4/20.
//  Copyright © 2020 BobaHasseb. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class NewsViewController: UIViewController, BaseViewController {
    // MARK: - Outlets
    @IBOutlet weak var newsTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var titleLabel: UILabel!
    // MARK: - RxSwif Variables
    let disposeBag: DisposeBag = DisposeBag()
    let isSuccessTableView = PublishSubject<[NewsItem]>()
    // MARK: - Variables
    let viewModel = NewsViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        regiserNibs()
        setUpBindings()
        setupTableViewBindings()
        bindTableViewSelected()
        self.searchBar.resignFirstResponder()
    }
    override func viewWillAppear(_ animated: Bool) {
        viewModel.getNewsData()
        self.searchBar.resignFirstResponder()
        newsTableView.rowHeight = 140
    }
    // MARK: - RegisterNib
    func regiserNibs() {
        newsTableView.registerNib(identifier: R.nib.newsTableViewCell.name)
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
                if let news = items.data?.data {
                    self.isSuccessTableView.onNext(news)
                }
            }).disposed(by: disposeBag)
    }
    func setupTableViewBindings() {
        self.isSuccessTableView
            .observeOn(MainScheduler.instance)
            .bind(to: newsTableView
                .rx
                .items(cellIdentifier: R.nib.newsTableViewCell.name,
                       cellType: NewsTableViewCell.self)) { (_, item, cell) in
                   cell.itemCell = item
            }.disposed(by: disposeBag)
    }
    private func bindTableViewSelected() {
         Observable
                 .zip(
                     newsTableView
                         .rx
                         .itemSelected, newsTableView
                         .rx
                         .modelSelected(NewsItem.self)
                 )
                 .bind { [weak self] _, model in
                     guard let self = self else { return }
                     if let destinationVC =
                        NewsDetailsViewController.instantiateFromNib() {
                        destinationVC.newsItem =  model
                        self.navigationController?.pushViewController(destinationVC, animated: true)
                     }}.disposed(by: disposeBag)
    }
}
