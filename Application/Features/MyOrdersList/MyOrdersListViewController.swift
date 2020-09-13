//
//  MyOrdersListViewController.swift
//  Src
//
//  Created by BobaHasseb on 8/19/20.
//  Copyright © 2020 BobaHasseb. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MyOrdersListViewController: UIViewController, BaseViewController {
    // MARK: - Outlets
    @IBOutlet weak var orderListTableView: UITableView!
    // MARK: - RxSwif Variables
    let disposeBag: DisposeBag = DisposeBag()
    let isSuccessTableView = PublishSubject<[MyOrdersListItem]>()
    // MARK: - Variables
    let viewModel = MyOrdersListViewModel()
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        regiserNibs()
        setUpBindings()
        setupTableViewBindings()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
        viewModel.getOrdersListData()
        orderListTableView.rowHeight = 55
    }
    // MARK: - RegisterNib
    func regiserNibs() {
        orderListTableView.registerNib(identifier:
            R.nib.myOrdersListTableViewCell.name)
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
                if let orderItems = items.data?.data {
                    if orderItems.count > 0 {
                        self.orderListTableView.isHidden = false
                        self.isSuccessTableView.onNext(orderItems)
                    }
                }
            }).disposed(by: disposeBag)
    }
    func setupTableViewBindings() {
        self.isSuccessTableView
            .observeOn(MainScheduler.instance)
            .bind(to: orderListTableView
                .rx
                .items(cellIdentifier: R.nib.myOrdersListTableViewCell.name,
                       cellType: MyOrdersListTableViewCell.self)) { (_, item, cell)
                        in
                        cell.orderDetailsButton.rx.tap.asObservable()
                            .filter({ (_) -> Bool in
                                    return true
                            })
                            .subscribe { _ in
                                 let destinationVC =
                                    MyOrdersDetailsViewController.instantiate(fromAppStoryboard: .main)
                                destinationVC.orderDetailsId =  item.id
                                   self.navigationController?.pushViewController(destinationVC, animated: true)
                            }
                        .disposed(by: cell.dispoedBag)
                   cell.itemCell = item
            }.disposed(by: disposeBag)
    }
    // MARK: - Back Button Pressed
    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
