//
//  PhotoGraphersViewModel.swift
//  Src
//
//  Created by BobaHasseb on 9/6/20.
//  Copyright © 2020 BobaHasseb. All rights reserved.
//

import Foundation
import RxSwift

class PhotosListViewModel: BaseViewModel {
    // MARK: - RxSwif Variables
    let isSuccess: PublishSubject<CompanyProductsModel> =
        PublishSubject()
    let isLoading: PublishSubject<Bool> = PublishSubject()
    let isError: PublishSubject<ErrorMessage> = PublishSubject()
    let disposeBag: DisposeBag = DisposeBag()
    // MARK: - ViewModel Variables
    let repository: PhotoListRepository
    var message = ""
    // MARK: - init
    public init (_ repo: PhotoListRepository = PhotoListRepository()) {
        repository = repo
        isSuccess.disposed(by: disposeBag)
        configureDisposeBag()
    }
    func getPhotosData(idd: Int) {
        self.isLoading.onNext(true)
        repository.getPhotostData(idd: idd) { [weak self] (result) in
            guard let self = self else {
                return
            }
            self.isLoading.onNext(false)
            switch result {
            case .success(let data):
                if let data = data as? CompanyProductsModel {
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
