//
//  CartViewModel.swift
//  Src
//
//  Created by BobaHasseb on 8/13/20.
//  Copyright © 2020 BobaHasseb. All rights reserved.
//

import Foundation
import RxSwift

class CartViewModel: BaseViewModel {
    // MARK: - RxSwif Variables
    let isSuccess: PublishSubject<CartModel> = PublishSubject()
    let isSuccessUpdateCart: PublishSubject<UpdateCartModel> = PublishSubject()
    let isLoading: PublishSubject<Bool> = PublishSubject()
    let isError: PublishSubject<ErrorMessage> = PublishSubject()
    let disposeBag: DisposeBag = DisposeBag()
    // MARK: - ViewModel Variables
    let repository: CartRepository
    var message = ""
    // MARK: - init
    public init (_ repo: CartRepository = CartRepository()) {
        repository = repo
        isSuccess.disposed(by: disposeBag)
        configureDisposeBag()
    }
    // MARK: - Call Cart Api
     func getCartData() {
         self.isLoading.onNext(true)
         repository.getCartData { [weak self] (result) in
             guard let self = self else {
                 return
             }
             self.isLoading.onNext(false)
             switch result {
             case .success(let data):
                 if let data = data as? CartModel {
                     self.message = "success"
                     self.isSuccess.onNext(data)
                 }
             case .failure(let error):
                 self.isLoading.onNext(false)
                 if error == .authenticationError {
                     self.message = "please, try to login again"
                 }
                 let error = ErrorMessage(title: "Error", message: self.message,
                                          action: self.buttonAction)
                 self.isError.onNext(error)
             }
         }
     }
    // MARK: - Call Update Cart Api
    func updateCart(rowId: String, productId: Int, newQuantity: Int) {
         self.isLoading.onNext(true)
        repository.updateCart(with: productId, and: newQuantity, and: rowId) { [weak self] (result) in
             guard let self = self else {
                 return
             }
             self.isLoading.onNext(false)
             switch result {
             case .success(let data):
                 if let data = data as? UpdateCartModel {
                     self.message = "success"
                     self.isSuccessUpdateCart.onNext(data)
                 }
             case .failure(let error):
                 self.isLoading.onNext(false)
                 if error == .authenticationError {
                     self.message = "please, try to login again"
                 }
                 let error = ErrorMessage(title: "Error", message: self.message,
                                          action: self.buttonAction)
                 self.isError.onNext(error)
             }
         }
     }
    @objc func buttonAction() {
        if let loginViewController = LoginViewController.instantiateFromNib() {
                navigateToNavigationController(using: loginViewController)
            }
        }
    // MARK: - Navigation
    func navigateToNavigationController(using controller: UIViewController) {
        let navController = UINavigationController(rootViewController: controller)
        UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController
            = navController
        }
}
