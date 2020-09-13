//
//  MyOrdersDetailsViewController.swift
//  Src
//
//  Created by BobaHasseb on 8/19/20.
//  Copyright © 2020 BobaHasseb. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MyOrdersDetailsViewController: UIViewController, BaseViewController {
    // MARK: - Outlets
    @IBOutlet weak var orderDetailsTableView: UITableView!
    @IBOutlet weak var orderId: UILabel!
    @IBOutlet weak var orderTotal: UILabel!
    @IBOutlet weak var orderStatus: UILabel!
    @IBOutlet weak var totalBeforeDiscountLabel: UILabel!
    @IBOutlet weak var totalAfterDiscountLabel: UILabel!
    @IBOutlet weak var couponDiscountLabel: UILabel!
    @IBOutlet weak var shippingLabel: UILabel!
    // MARK: - RxSwif Variables
    let disposeBag: DisposeBag = DisposeBag()
    let isSuccessTableView = PublishSubject<[MyOrdersDetailsItem]>()
    // MARK: - Variables
    let viewModel = MyOrdersDetailsViewModel()
    var orderDetailsId: Int?
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
        if let orderId = orderDetailsId {
            viewModel.getOrderDetailsData(idd: orderId)
        }
        orderDetailsTableView.rowHeight = 55
    }
    // MARK: - RegisterNib
    func regiserNibs() {
        orderDetailsTableView.registerNib(identifier: R.nib.cartTableViewCell.name)
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
                if let orderItems = items.data?.item_line {
                    self.orderDetailsTableView.isHidden = false
                    self.isSuccessTableView.onNext(orderItems)
                }
                if items.data?.order?.count ?? 0 > 0 {
                    if let orderId = items.data?.order?[0].id {
                        self.orderId.text = String(orderId)
                    }
                    if let total = items.data?.order?[0].total, let currancy =
                        items.data?.order?[0].currency {
                        self.orderTotal.text = String(total) + currancy
                        self.totalBeforeDiscountLabel.text = String(total) + currancy
                        self.totalAfterDiscountLabel.text = String(total) + currancy
                    }
                    if let orderStatus = items.data?.order?[0].order_status?.name {
                        self.orderStatus.text = orderStatus
                    }
                    if let discountValue = items.data?.order?[0].discount_order?[0].value {
                        self.couponDiscountLabel.text = String(discountValue)
                    }
                }
            }).disposed(by: disposeBag)
    }
    func setupTableViewBindings() {
        self.isSuccessTableView
            .observeOn(MainScheduler.instance)
            .bind(to: orderDetailsTableView
                .rx
                .items(cellIdentifier: R.nib.cartTableViewCell.name,
                       cellType: CartTableViewCell.self)) { (_, item, cell) in
                   cell.orderItemCell = item
            }.disposed(by: disposeBag)
    }
    // MARK: - Back Button Pressed
    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
