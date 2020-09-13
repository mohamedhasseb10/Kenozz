//
//  LoginViewController.swift
//  Src
//
//  Created by BobaHasseb on 8/5/20.
//  Copyright © 2020 BobaHasseb. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class LoginViewController: UIViewController {
    // MARK: - Outlets
     @IBOutlet weak var signInLabel: UILabel!
     @IBOutlet weak var emailAddessLabel: UILabel!
     @IBOutlet weak var passwordLabel: UILabel!
     @IBOutlet weak var emailTextField: UITextField!
     @IBOutlet weak var passwordTextField: UITextField!
     @IBOutlet weak var signInButton: UIButton!
     @IBOutlet weak var signUpButton: UIButton!
     @IBOutlet weak var forgetPasswordButton: UIButton!
     // MARK: - Controller Variables
     let viewModel = LoginViewModel()
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
    // MARK: - CallBack
    func createCallbacks () {
        self.signInButton.rx.tap.asObservable()
            .filter({ (_) -> Bool in
                let checkErrorExisting = self.viewModel.validateEntries(email:
                    self.emailTextField.text, password: self.passwordTextField.text)
                if !checkErrorExisting {
                    return false
                }
                    return true
            })
            .subscribe { _ in
                self.emailTextField.resignFirstResponder()
                self.passwordTextField.resignFirstResponder()
                self.viewModel.login(with: self.emailTextField.text!, and: self.passwordTextField.text!)
            }
            .disposed(by: disposeBag)
        viewModel
            .isSuccess
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (_) in
                if let destinationVC = MainPageViewController.instantiateFromNib() {
                    self.navigate(to: destinationVC)
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
    func navigate(to controller: UIViewController) {
        UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController
            = controller
        }
    @IBAction func signUp(_ sender: Any) {
        if let destinationVC = SignUpViewController.instantiateFromNib() {
            self.navigationController?.pushViewController(destinationVC, animated: true)
        }
    }
}
