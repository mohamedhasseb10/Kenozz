//
//  CompleteOrderViewController.swift
//  Src
//
//  Created by BobaHasseb on 8/13/20.
//  Copyright © 2020 BobaHasseb. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class CompleteOrderViewController: UIViewController, BaseViewController {
    // MARK: - Outlets
    @IBOutlet weak var editAccountLabel: UILabel!
    @IBOutlet weak var accountData: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var confirmPasswordLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var acceptButton: UIButton!
    @IBOutlet weak var rejectButton: UIButton!
    @IBOutlet weak var mainView: UIView!
    // MARK: - RxSwif Variables
    let disposeBag: DisposeBag = DisposeBag()
    // MARK: - Variables
    let viewModel = CompleteOrderViewModel()
    var sendOrderModel = [SendOrderModel]()
    var sendOrderDictionnary = [[String: Any]]()
    override func viewDidLoad() {
        super.viewDidLoad()
        addGestureForView()
        setUpBindings()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
    }
    // MARK: - Hide Keyboard
     func addGestureForView() {
         let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.viewTapped(gestureRecognizer:)))
         view.addGestureRecognizer(tapGesture)
     }
     @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer) {
         view.endEditing(true)
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
                guard let orderID = items.data?[0].order_id else { return }
                let alert = UIAlertController(title: "Congratulation",
                        message:
                    "you make order success, and your order id: \(orderID)",
                preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok",
                style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }).disposed(by: disposeBag)
    }
    // MARK: - Complete Order Pressed
    @IBAction func completeOrderButtonAction(_ sender: Any) {
        for orderItem in sendOrderModel {
            let dic = ["id": orderItem.id, "qty": orderItem.qty]
            sendOrderDictionnary.append(dic)
        }
        viewModel.makeOrder(item: sendOrderDictionnary)
    }
    // MARK: - Back Button Pressed
    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
