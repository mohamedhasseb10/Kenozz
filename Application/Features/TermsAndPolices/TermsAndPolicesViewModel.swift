//
//  TermsAndPolicesViewModel.swift
//  Src
//
//  Created by BobaHasseb on 8/29/20.
//  Copyright © 2020 BobaHasseb. All rights reserved.
//

import Foundation
import RxSwift

class TermsAndpolicesViewModel: BaseViewModel {
    // MARK: - RxSwif Variables
    let isSuccess: PublishSubject<ConfigModel> = PublishSubject()
    let isLoading: PublishSubject<Bool> = PublishSubject()
    let isError: PublishSubject<ErrorMessage> = PublishSubject()
    let disposeBag: DisposeBag = DisposeBag()
    // MARK: - ViewModel Variables
    let repository: TermsAndpolicesRepository
    var message = ""
    // MARK: - init
    public init (_ repo: TermsAndpolicesRepository = TermsAndpolicesRepository()) {
        repository = repo
        isSuccess.disposed(by: disposeBag)
        configureDisposeBag()
    }
    // MARK: - Call Config Api
     func getConfigData() {
         self.isLoading.onNext(true)
         repository.getConfigData { [weak self] (result) in
             guard let self = self else {
                 return
             }
             self.isLoading.onNext(false)
             switch result {
             case .success(let data):
                 if let data = data as? ConfigModel {
                     self.message = "success"
                     self.isSuccess.onNext(data)
                 }
             case .failure(let error):
                 self.isLoading.onNext(false)
                 if error == .authenticationError {
                     self.message = "please, try to login again"
                 }
                 let error = ErrorMessage(title: "Error", message: self.message,
                                          action: nil)
                 self.isError.onNext(error)
             }
         }
     }
}
