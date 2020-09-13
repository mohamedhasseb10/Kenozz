//
//  CartViewController.swift
//  Src
//
//  Created by BobaHasseb on 8/4/20.
//  Copyright © 2020 BobaHasseb. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class CartViewController: UIViewController, BaseViewController {
    // MARK: - Outlets
    @IBOutlet weak var cartTableView: UITableView!
    @IBOutlet weak var totalBeforeDiscountLabel: UILabel!
    @IBOutlet weak var totalAfterDiscountLabel: UILabel!
    @IBOutlet weak var couponDiscountLabel: UILabel!
    @IBOutlet weak var shippingLabel: UILabel!
    // MARK: - RxSwif Variables
    let disposeBag: DisposeBag = DisposeBag()
    let isSuccessTableView = PublishSubject<[CartItem]>()
    // MARK: - Variables
    let viewModel = CartViewModel()
    var sendOrderModel = [SendOrderModel]()
    var indexPath = 0
    var quantity = 1
    var userDefaults = UserDefaults.standard
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        addGestureForView()
        regiserNibs()
        setUpBindings()
        setupTableViewBindings()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = false
        viewModel.getCartData()
        cartTableView.rowHeight = 55
        tabBarItem.badgeColor = .red
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    // MARK: - Hide Keyboard
     func addGestureForView() {
         let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.viewTapped(gestureRecognizer:)))
         view.addGestureRecognizer(tapGesture)
     }
     @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer) {
         view.endEditing(true)
     }
    // MARK: - RegisterNib
    func regiserNibs() {
        cartTableView.registerNib(identifier: R.nib.cartTableViewCell.name)
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
                if let cartItems = items.data?.items {
                    if cartItems.count > 0 {
                        self.cartTableView.isHidden = false
                        self.isSuccessTableView.onNext(cartItems)
                        self.userDefaults.badgeValue = String(cartItems.count)
                        self.tabBarItem.badgeValue = String(cartItems.count)
                    }
                }
                if let total = items.data?.subtotal {
                    self.totalBeforeDiscountLabel.text = total + " KWD"
                    self.totalAfterDiscountLabel.text = total + " KWD"
                }
            }).disposed(by: disposeBag)
        viewModel
            .isSuccessUpdateCart.observeOn(MainScheduler.instance)
            .subscribe({ [weak self] (data) in
                guard let self = self else { return }
                guard let items = data.element else { return }
                if items.success == true {
                    self.cartTableView.indexPathsForVisibleRows?.forEach { index in
                        if let cell = self.cartTableView.cellForRow(at: index) as?
                            CartTableViewCell {
                            if index.row == self.indexPath {
                                cell.productNumber.text = String(self.quantity)
                            }
                        }
                    }
                }
            }).disposed(by: disposeBag)

    }
    func setupTableViewBindings() {
        self.isSuccessTableView
            .observeOn(MainScheduler.instance)
            .bind(to: cartTableView
                .rx
                .items(cellIdentifier: R.nib.cartTableViewCell.name,
                       cellType: CartTableViewCell.self)) { (indexPath, item, cell) in
                        guard let idd = item.id else { return }
                        if let qty = item.qty {
                            let quantity = String(qty)
                            self.sendOrderModel.append(SendOrderModel(id:
                                String(idd), qty: quantity))
                        }
                        cell.increaseQuantity.rx.tap.asObservable()
                            .filter({ (_) -> Bool in
                                    return true
                            })
                            .subscribe { _ in
                               if let quantity = Int(cell.productNumber.text!) {
                                var quantityNumber = quantity
                                quantityNumber += 1
                                if let rowId = item.rowId, let productId = item.id {
                                    self.viewModel.updateCart(rowId: rowId,
                                            productId: productId,
                                            newQuantity: quantityNumber)
                                    self.indexPath = indexPath
                                    self.quantity = quantityNumber
                                }
                                }
                            }
                        .disposed(by: cell.dispoedBag)
                        cell.decreaseQuantity.rx.tap.asObservable()
                            .filter({ (_) -> Bool in
                                    return true
                            })
                            .subscribe { _ in
                                if let quantity = Int(cell.productNumber.text!) {
                                var quantityNumber = quantity
                                if quantityNumber != 1 { quantityNumber -= 1 }
                                    if let rowId = item.rowId, let productId = item.id {
                                        self.viewModel.updateCart(rowId: rowId,
                                           productId: productId, newQuantity: quantityNumber)
                                        self.indexPath = indexPath
                                        self.quantity = quantityNumber
                                    }
                                }
                            }
                        .disposed(by: cell.dispoedBag)
                   cell.itemCell = item
            }.disposed(by: disposeBag)
    }
   @objc func pressButton() {
        viewModel.getCartData()
    }
    // MARK: - Payment Pressed
    @IBAction func paymentAction(_ sender: Any) {
        if let destinationVC = CompleteOrderViewController.instantiateFromNib() {
            destinationVC.sendOrderModel = sendOrderModel
            self.navigationController?.pushViewController(destinationVC,
                                                          animated: true)
        }
    }
    // MARK: - Continue Shopping Pressed
    @IBAction func continueShoppingAction(_ sender: Any) {
        let kenozTrolly = TabBarController.instantiate(fromAppStoryboard: .main)
        kenozTrolly.type = .kinozTrolley
        UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController = kenozTrolly
    }
}
