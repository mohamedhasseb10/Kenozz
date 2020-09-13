//
//  LoginViewModel.swift
//  Src
//
//  Created by BobaHasseb on 8/5/20.
//  Copyright © 2020 BobaHasseb. All rights reserved.
//

import Foundation
import RxSwift

class LoginViewModel: BaseViewModel {
    // MARK: - RxSwif Variables
    let isSuccess: PublishSubject<Bool> = PublishSubject()
    let isLoading: PublishSubject<Bool> = PublishSubject()
    let isError: PublishSubject<ErrorMessage> = PublishSubject()
    let disposeBag: DisposeBag = DisposeBag()
    let repository: LoginRepository
    var userDefaults = UserDefaults.standard
    // MARK: - init
    public init (_ repo: LoginRepository = LoginRepository()) {
        repository = repo
        isSuccess.disposed(by: disposeBag)
        configureDisposeBag()
    }
    // MARK: - Validation
    func validateEntries( email: String?, password: String?) -> Bool {
        if email?.isEmpty ?? true {
            if password?.isEmpty ?? true {
                showError(message: "Email field and Password Field are Empty",
                          title: "Error")
                return false
            } else {
                showError(message: "Email field is Empty",
                          title: "Error")
                return false
            }
        } else if password?.isEmpty ?? true {
            showError(message: "Password Field is Empty",
                      title: "Error")
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
         repository.login(with: email, and: password) { [weak self] (result) in
             guard let self = self else {
                 return
             }
             self.isLoading.onNext(false)
             switch result {
             case .success(let data):
                 if let data = data as? LoginModel {
                     switch data.message {
                     case 200:
                       self.saveUserData(from: data)
                        print("welcome")
                        self.isSuccess.onNext(true)
                     default:
                         let error =
                             ErrorMessage(title: "Error",
                                          message: "Please try login again!",
                                          action: nil)
                         self.isError.onNext(error)
                     }
                 }
             case .failure(let error):
                 self.isLoading.onNext(false)
                 if error == .jsonConversionFailure {
                    let error = ErrorMessage(title: "Error", message:
                        "Email or Password is Invalid", action: nil)
                    self.isError.onNext(error)
                 } else if error == .connectionError {
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
    func saveUserData( from: LoginModel) {
        userDefaults.isLoggedIn = true
        userDefaults.userID = from.data?.id
        userDefaults.userName = from.data?.username
        userDefaults.name = from.data?.name
        userDefaults.lName = from.data?.lname
        userDefaults.userEmail = from.data?.email
        userDefaults.userImagePath = from.data?.avatar
        userDefaults.apiToken = from.data?.api_token
    }
}
