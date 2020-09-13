//
//  ProductDetailsViewModel.swift
//  Src
//
//  Created by BobaHasseb on 8/12/20.
//  Copyright © 2020 BobaHasseb. All rights reserved.
//

import Foundation
import RxSwift

class ProductDetailsViewModel: BaseViewModel {
    // MARK: - RxSwif Variables
    let isSuccess: PublishSubject<Bool> = PublishSubject()
    let isSuccessAddFavourite: PublishSubject<Bool> = PublishSubject()
    let isSuccessGetProductReview: PublishSubject<ProductReviewModel> = PublishSubject()
    let isLoading: PublishSubject<Bool> = PublishSubject()
    let isError: PublishSubject<ErrorMessage> = PublishSubject()
    let disposeBag: DisposeBag = DisposeBag()
    let repository: ProductDetailsRepository
    var userDefaults = UserDefaults.standard
    // MARK: - init
    public init (_ repo: ProductDetailsRepository = ProductDetailsRepository()) {
        repository = repo
        isSuccess.disposed(by: disposeBag)
        configureDisposeBag()
    }
    // MARK: - Error Message
    func showError(message: String, title: String) {
        let error =
            ErrorMessage(title: title,
                         message: message, action: nil)
        self.isError.onNext(error)
    }
    // MARK: - Call Add To Cart Api
    func addToCart(with productId: Int, and quantity: String) {
         self.isLoading.onNext(true)
         repository.addToCart(with: productId,
                              and: quantity) { [weak self] (result) in
             guard let self = self else {
                 return
             }
             self.isLoading.onNext(false)
             switch result {
             case .success(let data):
                 if let data = data as? ProductDetailsModel {
                    print(data)
                     switch data.error {
                     case 0:
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
                 if error == .connectionError {
                    let error = ErrorMessage(title: "Error", message:
                        "please check your Network", action: nil)
                    self.isError.onNext(error)
                 } else {
                    let error = ErrorMessage(title: "Error", message: "please try login again", action: nil)
                    self.isError.onNext(error)
                 }
             }
         }
    }
    // MARK: - Call Add To Favourite Api
    func addToFavourite(with productId: String) {
         self.isLoading.onNext(true)
        repository.addToFavourite(productId: productId) { [weak self] (result) in
             guard let self = self else {
                 return
             }
             self.isLoading.onNext(false)
             switch result {
             case .success(let data):
                 if let data = data as? AddToFavouriteModel {
                    print(data)
                     switch data.error {
                     case 0:
                        print("welcome")
                        self.isSuccessAddFavourite.onNext(true)
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
                 if error == .connectionError {
                    let error = ErrorMessage(title: "Error", message:
                        "please check your Network", action: nil)
                    self.isError.onNext(error)
                 } else {
                    let error = ErrorMessage(title: "Error", message: "please try login again", action: nil)
                    self.isError.onNext(error)
                 }
             }
         }
    }
    // MARK: - Call Product Review Api
    func getProductReview(with productId: Int) {
         self.isLoading.onNext(true)
        repository.getProductReview(productId: productId) { [weak self] (result) in
             guard let self = self else {
                 return
             }
             self.isLoading.onNext(false)
             switch result {
             case .success(let data):
                 if let data = data as? ProductReviewModel {
                     switch data.message {
                     case 200:
                        print(data)
                        self.isSuccessGetProductReview.onNext(data)
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
                 if error == .connectionError {
                    let error = ErrorMessage(title: "Error", message:
                        "please check your Network", action: nil)
                    self.isError.onNext(error)
                 } else {
                    let error = ErrorMessage(title: "Error", message: "please try login again", action: nil)
                    self.isError.onNext(error)
                 }
             }
         }
    }
}
