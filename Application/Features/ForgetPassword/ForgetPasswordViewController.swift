//
//  ForgetPasswordViewController.swift
//  Src
//
//  Created by BobaHasseb on 8/5/20.
//  Copyright © 2020 BobaHasseb. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ForgetPasswordViewController: UIViewController {
    // MARK: - Outlets
     @IBOutlet weak var restorePasswordLabel: UILabel!
     @IBOutlet weak var emailAddessLabel: UILabel!
     @IBOutlet weak var hintLabel: UILabel!
     @IBOutlet weak var emailTextField: UITextField!
     @IBOutlet weak var signInButton: UIButton!
     // MARK: - Controller Variables
     let viewModel = ForgetPasswordViewModel()
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
     }
    // MARK: - Hide Keyboard
     func addGestureForView() {
         let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.viewTapped(gestureRecognizer:)))
         view.addGestureRecognizer(tapGesture)
     }
     @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer) {
         view.endEditing(true)
     }
    // MARK: - Back Button Pressed
    @IBAction func backButtonAction(_ sender: Any) {
    }
    // MARK: - CallBack
    func createCallbacks () {
        self.signInButton.rx.tap.asObservable()
            .filter({ (_) -> Bool in
                let checkErrorExisting = self.viewModel.validateEntries(email:
                    self.emailTextField.text, password: "admin")
                if !checkErrorExisting {
                    return false
                }
                    return true
            })
            .subscribe { _ in
                self.emailTextField.resignFirstResponder()
                self.viewModel.login(with: self.emailTextField.text!, and: "admin")
            }
            .disposed(by: disposeBag)
        viewModel
            .isSuccess
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (_) in
                print("mabrok ya sa7by")
                // go to login screen
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
