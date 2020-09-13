//
//  EditAccountViewController.swift
//  Src
//
//  Created by BobaHasseb on 8/7/20.
//  Copyright © 2020 BobaHasseb. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class EditAccountViewController: UIViewController, BaseViewController {
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
     // MARK: - Controller Variables
     let viewModel = EditAccountViewModel()
     // MARK: - RxSwif Variables
     let disposeBag: DisposeBag = DisposeBag()
     // MARK: - init
     override func viewDidLoad() {
         super.viewDidLoad()
         addGestureForView()
         createCallbacks()
     }
     override func viewWillAppear(_ animated: Bool) {
         self.navigationController?.navigationBar.isHidden = false
        mainView.roundCorners(radius: 10,
                              corners: [.layerMinXMinYCorner,
                                        .layerMaxXMinYCorner])
        acceptButton.roundCorners(radius: 10, corners: [.layerMaxXMaxYCorner])
        rejectButton.roundCorners(radius: 10, corners: [.layerMinXMaxYCorner])
        addressTextField.contentVerticalAlignment = .top
     }
    // MARK: - Hide Keyboard
     func addGestureForView() {
         let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.viewTapped(gestureRecognizer:)))
         view.addGestureRecognizer(tapGesture)
     }
     @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer) {
         view.endEditing(true)
     }
    // MARK: - CallBack
    func createCallbacks () {
        self.acceptButton.rx.tap.asObservable()
                .filter({ (_) -> Bool in
                        return true
                })
                .subscribe { _ in
                    self.nameTextField.resignFirstResponder()
                    self.emailTextField.resignFirstResponder()
                    self.phoneNumberTextField.resignFirstResponder()
                    self.addressTextField.resignFirstResponder()
                    self.passwordTextField.resignFirstResponder()
                    self.confirmPasswordTextField.resignFirstResponder()
                    self.viewModel.editAccount(with: self.addressTextField.text!,
                                               and: self.nameTextField.text!,
                                               and: self.emailTextField.text!, userId: "6")
                }
                .disposed(by: disposeBag)
            viewModel
                .isSuccess
                .observeOn(MainScheduler.instance)
                .subscribe(onNext: { (_) in
                    print("mabrok ya sa7by")
                    UIApplication
                        .shared
                        .windows
                        .filter {$0.isKeyWindow}.first?.rootViewController =
                        TabBarController.instantiate(fromAppStoryboard: .main)
                }).disposed(by: disposeBag)

            viewModel.isLoading
                .observeOn(MainScheduler.instance)
                .bind(to: self.rx.isAnimating)
                .disposed(by: disposeBag)

            viewModel
                .isError
                .observeOn(MainScheduler.instance)
                .bind(to: self.rx.isError)
                .disposed(by: disposeBag)
        }
}
