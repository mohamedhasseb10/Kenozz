//
//  EditAccountViewModel.swift
//  Src
//
//  Created by BobaHasseb on 8/7/20.
//  Copyright © 2020 BobaHasseb. All rights reserved.
//

import Foundation
import RxSwift

class EditAccountViewModel: BaseViewModel {
    let isSuccess: PublishSubject<Bool> = PublishSubject()
    let isLoading: PublishSubject<Bool> = PublishSubject()
    let isError: PublishSubject<ErrorMessage> = PublishSubject()
    let disposeBag: DisposeBag = DisposeBag()
    let repository: EditAccountRepository
    public init(_ repo: EditAccountRepository = EditAccountRepository()) {
        repository = repo
        isSuccess.disposed(by: disposeBag)
        configureDisposeBag()
    }
    func showError(message: String, title: String) {
        let error =
            ErrorMessage(title: title,
                         message: message, action: nil)
        self.isError.onNext(error)
    }
    // MARK: - Call Login Api
    func editAccount(with profileImage: String, and name: String,
                     and email: String, userId: String) {
         self.isLoading.onNext(true)
        repository.editAccount(with: profileImage, and: email, and: name, and: userId) { [weak self] (result) in
             guard let self = self else {
                 return
             }
             switch result {
             case .success(let data):
                 if let data = data as? EditAccountModel {
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
                 if error == .jsonConversionFailure {
                    let error = ErrorMessage(title: "Error", message:
                        "Email is Exists ", action: nil)
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
}
