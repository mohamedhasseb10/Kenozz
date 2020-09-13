//
//  SignUpViewModel.swift
//  Src
//
//  Created by BobaHasseb on 8/5/20.
//  Copyright © 2020 BobaHasseb. All rights reserved.
//

import Foundation
import RxSwift

class SignUpViewModel: BaseViewModel {
    let isSuccess: PublishSubject<Bool> = PublishSubject()
    let isLoading: PublishSubject<Bool> = PublishSubject()
    let isError: PublishSubject<ErrorMessage> = PublishSubject()
    let disposeBag: DisposeBag = DisposeBag()
    let repository: SignUpRepository
    var userDefaults = UserDefaults.standard
    public init(_ repo: SignUpRepository = SignUpRepository()) {
        repository = repo
        isSuccess.disposed(by: disposeBag)
        configureDisposeBag()
    }
    func validateEntries( name: String?, email: String?,
                          password: String?, confirmPassword: String?) -> Bool {
        if name?.isEmpty ?? true {
            showError(message: "Name field is required", title: "Name Error ")
            return false
        } else if email?.isEmpty ?? true {
            showError(message: "Email field is required", title: "Email Error")
            return false
        } else if !(email?.isValidEmail() ?? false) {
            showError(message: "Please Enter Valid Email",
                      title: "Email Error")
            return false
        } else if password?.isEmpty ?? true {
             showError(message: "Password field is required",
                       title: "Password Error ")
            return false
        } else if confirmPassword?.isEmpty ?? true {
             showError(message: "ConfirmPassword field is required",
                       title: "ConfirmPassword Error ")
            return false
        } else if password != confirmPassword {
            showError(message: "Password field not match ConfirmPassword field",
                      title: " Error")
            return false
        } else {
            return true
        }
    }
    func showError(message: String, title: String) {
        let error =
            ErrorMessage(title: title,
                         message: message, action: nil)
        self.isError.onNext(error)
    }
    // MARK: - Call Login Api
    func signUp(with name: String, and email: String,
                and password: String, and profileImage: String) {
         self.isLoading.onNext(true)
        repository.signUp(with: email, and: name, and: password,
                          and: profileImage) { [weak self] (result) in
             guard let self = self else {
                 return
             }
             self.isLoading.onNext(false)
             switch result {
             case .success(let data):
                 if let data = data as? SignUpModel {
                     switch data.message {
                     case 200:
                        self.saveUserData(from: data)
                        print("welcome")
                        self.isSuccess.onNext(true)
                     case 401:
                        let error = ErrorMessage(title: "Error", message:
                            "Email is Exists", action: nil)
                        self.isError.onNext(error)
                     default:
                         let error =
                             ErrorMessage(title: "Error",
                                          message: "Please try login again!",
                                          action: nil)
                         self.isError.onNext(error)
                     }
                 }
             case .failure(let error):
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
    func saveUserData( from: SignUpModel) {
        userDefaults.isLoggedIn = true
        userDefaults.userID = from.data?.id
        userDefaults.userName = from.data?.username
        userDefaults.name = from.data?.name
        userDefaults.lName = from.data?.lname
        userDefaults.userEmail = from.data?.email
    }
}
