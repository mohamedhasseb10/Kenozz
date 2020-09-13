//
//  SellerViewModel.swift
//  Src
//
//  Created by BobaHasseb on 8/11/20.
//  Copyright © 2020 BobaHasseb. All rights reserved.
//

import Foundation
import RxSwift

class SellerViewModel: BaseViewModel {
    // MARK: - RxSwif Variables
    let isSuccessShop: PublishSubject<CompanyProductsModel> =
        PublishSubject()
    let isLoadingShop: PublishSubject<Bool> = PublishSubject()
    let isErrorShop: PublishSubject<ErrorMessage> = PublishSubject()
    let isSuccessAboutSeller: PublishSubject<AboutSellerModel> =
        PublishSubject()
    let isLoadingAboutSeller: PublishSubject<Bool> = PublishSubject()
    let isErrorAboutSeller: PublishSubject<ErrorMessage> = PublishSubject()
    let isLoading: PublishSubject<Bool> = PublishSubject()
    let isError: PublishSubject<ErrorMessage> = PublishSubject()
    let disposeBag: DisposeBag = DisposeBag()
    // MARK: - ViewModel Variables
    let repository: SellerRepository
    var message = ""
    // MARK: - init
    public init (_ repo: SellerRepository = SellerRepository()) {
        repository = repo
        isSuccessShop.disposed(by: disposeBag)
        configureDisposeBag()
    }
    // MARK: - Call home Api
    func getSellerProductData(idd: Int) {
        self.isLoadingShop.onNext(true)
        repository.getSellerProductData(idd: idd) { [weak self] (result) in
            guard let self = self else {
                return
            }
            self.isLoadingShop.onNext(false)
            switch result {
            case .success(let data):
                if let data = data as? CompanyProductsModel {
                    self.message = "success"
                    self.isSuccessShop.onNext(data)
                }
            case .failure(let error):
                self.isLoadingShop.onNext(false)
                if error == .authenticationError {
                    self.message = "please, try to login again"
                }
                let error = ErrorMessage(title: "Error", message: self.message,
                                         action: nil)
                self.isErrorShop.onNext(error)
            }
        }
    }
    func getAboutSellerData(idd: Int) {
        self.isLoadingAboutSeller.onNext(true)
        repository.getAboutSellerData(idd: idd) { [weak self] (result) in
            guard let self = self else {
                return
            }
            self.isLoadingAboutSeller.onNext(false)
            switch result {
            case .success(let data):
                if let data = data as? AboutSellerModel {
                    self.message = "success"
                    self.isSuccessAboutSeller.onNext(data)
                }
            case .failure(let error):
                self.isLoadingAboutSeller.onNext(false)
                if error == .authenticationError {
                    self.message = "please, try to login again"
                }
                let error = ErrorMessage(title: "Error", message: self.message,
                                         action: nil)
                self.isErrorAboutSeller.onNext(error)
            }
        }
    }
}
