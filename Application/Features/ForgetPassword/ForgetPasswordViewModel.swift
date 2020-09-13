//
//  ForgetPasswordViewModel.swift
//  Src
//
//  Created by BobaHasseb on 8/6/20.
//  Copyright © 2020 BobaHasseb. All rights reserved.
//

import Foundation
import RxSwift

class ForgetPasswordViewModel: BaseViewModel {
    // MARK: - RxSwif Variables
    let isSuccess: PublishSubject<Bool> = PublishSubject()
    let isLoading: PublishSubject<Bool> = PublishSubject()
    let isError: PublishSubject<ErrorMessage> = PublishSubject()
    let disposeBag: DisposeBag = DisposeBag()
    let repository: ForgetPasswordRepository
    var userDefaults = UserDefaults.standard
    // MARK: - init
    public init (_ repo: ForgetPasswordRepository =
        ForgetPasswordRepository()) {
        repository = repo
        isSuccess.disposed(by: disposeBag)
        configureDisposeBag()
    }
    // MARK: - Validation
    func validateEntries( email: String?, password: String?) -> Bool {
        if email?.isEmpty ?? true {
            showError(message: "Email field is required",
                      title: "Email Error")
            return false
        } else if !(email?.isValidEmail() ?? false) {
            showError(message: "Email field should be a valid email",
                      title: "Email Error")
            return false
        } else {
            return true
        }
    }
    // MARK: - Error Message
    func showError(message: String, title: String) {
        let error =
            ErrorMessage(title: title,
                         message: message, action: nil)
        self.isError.onNext(error)
    }
    // MARK: - Call Login Api
    func login(with email: String, and password: String) {
         self.isLoading.onNext(true)
         repository.forgetPassword(with: email, and: password) { [weak self] (result) in
             guard let self = self else {
                 return
             }
             switch result {
             case .success(let data):
                 if let data = data as? ForgetPasswordModel {
                     switch data.message {
                     case 200:
                        print("welcome")
                        self.isLoading.onNext(false)
                        self.isSuccess.onNext(true)
                     default:
                         self.isLoading.onNext(false)
                         let error =
                             ErrorMessage(title: "Error",
                                          message: "Please try login again!",
                                          action: nil)
                         self.isError.onNext(error)
                     }
                 }
             case .failure(let error):
                 self.isLoading.onNext(false)
                 if error == .connectionError {
                    let error = ErrorMessage(title: "Error", message:
                        "please check your Network", action: nil)
                    self.isError.onNext(error)
                 } else {
                    let error = ErrorMessage(title: "Error", message: error.localizedDescription, action: nil)
                    self.isError.onNext(error)
                 }
             }
         }
    }
}
