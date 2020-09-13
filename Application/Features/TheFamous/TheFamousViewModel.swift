//
//  TheFamousViewModel.swift
//  Src
//
//  Created by BobaHasseb on 8/10/20.
//  Copyright © 2020 BobaHasseb. All rights reserved.
//

import Foundation
import RxSwift

class TheFamousViewModel: BaseViewModel {
    // MARK: - RxSwif Variables
    let isSuccess: PublishSubject<ProductListModel> = PublishSubject()
    let isLoading: PublishSubject<Bool> = PublishSubject()
    let isError: PublishSubject<ErrorMessage> = PublishSubject()
    let disposeBag: DisposeBag = DisposeBag()
    // MARK: - ViewModel Variables
    let repository: TheFamousRepository
    var message = ""
    // MARK: - init
    public init (_ repo: TheFamousRepository = TheFamousRepository()) {
        repository = repo
        isSuccess.disposed(by: disposeBag)
        configureDisposeBag()
    }
    // MARK: - Call Product List Api
    func getProductListData(idd: Int) {
        self.isLoading.onNext(true)
        repository.getProductsData(idd: idd) { [weak self] (result) in
            guard let self = self else {
                return
            }
            self.isLoading.onNext(false)
            switch result {
            case .success(let data):
                if let data = data as? ProductListModel {
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
