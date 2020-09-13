//
//  SignUpViewController.swift
//  Src
//
//  Created by BobaHasseb on 8/5/20.
//  Copyright © 2020 BobaHasseb. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SignUpViewController: UIViewController {
    // MARK: - Outlets
     @IBOutlet weak var nameLabel: UILabel!
     @IBOutlet weak var emailAddessLabel: UILabel!
     @IBOutlet weak var passwordLabel: UILabel!
     @IBOutlet weak var confirmPasswordLabel: UILabel!
     @IBOutlet weak var signUpLabel: UILabel!
     @IBOutlet weak var profileImageLabel: UILabel!
     @IBOutlet weak var nameTextField: UITextField!
     @IBOutlet weak var emailTextField: UITextField!
     @IBOutlet weak var passwordTextField: UITextField!
     @IBOutlet weak var confirmPasswordTextField: UITextField!
     @IBOutlet weak var signUpButton: UIButton!
     @IBOutlet weak var agreeTermsPolicesAction: UIButton!
     // MARK: - Controller Variables
     let viewModel = SignUpViewModel()
     // MARK: - RxSwif Variables
     let disposeBag: DisposeBag = DisposeBag()
     // MARK: - init
     override func viewDidLoad() {
         super.viewDidLoad()
         addGestureForView()
         createCallbacks()
     }
     override func viewWillAppear(_ animated: Bool) {
         self.navigationController?.navigationBar.isHidden = true
     }
    // MARK: - Hide Keyboard
     func addGestureForView() {
         let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.viewTapped(gestureRecognizer:)))
         view.addGestureRecognizer(tapGesture)
     }
     @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer) {
         view.endEditing(true)
     }
    // MARK: - Terms Polices Pressed
    @IBAction func termsPolicesAction(_ sender: Any) {
    }
    // MARK: - Agree Terms polices Pressed
    @IBAction func agreeTermsPolicesAction(_ sender: Any) {
    }
    // MARK: - Select Profile Image Pressed
    @IBAction func selectProfileImageAction(_ sender: Any) {
    }
    // MARK: - Back Button Pressed
    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    // MARK: - CallBack
    func createCallbacks () {
        self.signUpButton.rx.tap.asObservable()
            .filter({ (_) -> Bool in
                let checkErrorExisting = self.viewModel.validateEntries(name:
                    self.nameTextField.text,
                    email: self.emailTextField.text,
                    password: self.passwordTextField.text,
                    confirmPassword: self.confirmPasswordTextField.text)
                if !checkErrorExisting {
                    return false
                }
                    return true
            })
            .subscribe { _ in
                self.nameTextField.resignFirstResponder()
                self.emailTextField.resignFirstResponder()
                self.passwordTextField.resignFirstResponder()
                self.confirmPasswordTextField.resignFirstResponder()
                self.viewModel.signUp(with: self.nameTextField.text!,
                and: self.emailTextField.text!,
                and: self.passwordTextField.text!,
                and: self.profileImageLabel.text!)
            }
            .disposed(by: disposeBag)
        viewModel
            .isSuccess
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (_) in
                if let loginViewController =
                    LoginViewController.instantiateFromNib() {
                    self.navigateToNavigationController(using:
                            loginViewController)
                    }
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
    // MARK: - Navigation
    func navigateToNavigationController(using controller: UIViewController) {
        let navController = UINavigationController(rootViewController:
            controller)
        UIApplication.shared.windows.filter {
            $0.isKeyWindow}.first?.rootViewController
            = navController
        }
}
