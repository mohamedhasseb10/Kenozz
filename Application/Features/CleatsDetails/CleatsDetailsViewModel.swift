//
//  CleatsDetailsViewModel.swift
//  Src
//
//  Created by BobaHasseb on 8/11/20.
//  Copyright © 2020 BobaHasseb. All rights reserved.
//

import Foundation
import RxSwift

class CleatsDetailsViewModel: BaseViewModel {
    // MARK: - RxSwif Variables
    let isSuccessSlider: PublishSubject<CleatsDetailsModel> = PublishSubject()
    let isLoadingSlider: PublishSubject<Bool> = PublishSubject()
    let isErrorSlider: PublishSubject<ErrorMessage> = PublishSubject()
    let isSuccessPhotoLibrary: PublishSubject<CleatsDetailsModel> = PublishSubject()
    let isLoadingPhotoLibrary: PublishSubject<Bool> = PublishSubject()
    let isErrorPhotoLibrary: PublishSubject<ErrorMessage> = PublishSubject()
    var isLoading: PublishSubject<Bool> = PublishSubject()
    var isError: PublishSubject<ErrorMessage> = PublishSubject()
    let disposeBag: DisposeBag = DisposeBag()
    // MARK: - ViewModel Variables
    let repository: CleatsDetailsRepository
    var message = ""
    // MARK: - init
    public init (_ repo: CleatsDetailsRepository = CleatsDetailsRepository()) {
        repository = repo
        isSuccessSlider.disposed(by: disposeBag)
        configureDisposeBag()
    }
    // MARK: - Call home Api
    func getCleatsDetailsSlider(idd: Int, type: Int) {
        self.isLoadingSlider.onNext(true)
        repository.getCleatsDetailsData(with: idd, and: type ) { [weak self] (result) in
            guard let self = self else {
                return
            }
            self.isLoadingSlider.onNext(false)
            switch result {
            case .success(let data):
                if let data = data as? CleatsDetailsModel {
                    self.message = "success"
                    self.isSuccessSlider.onNext(data)
                }
            case .failure(let error):
                self.isLoadingSlider.onNext(false)
                if error == .authenticationError {
                    self.message = "please, try to login again"
                }
                let error = ErrorMessage(title: "Error", message: self.message,
                                         action: nil)
                self.isErrorSlider.onNext(error)
            }
        }
    }
    func getCleatsDetailsLibraryImages(idd: Int, type: Int) {
        self.isLoadingPhotoLibrary.onNext(true)
        repository.getCleatsDetailsData(with: idd, and: type ) { [weak self] (result) in
            guard let self = self else {
                return
            }
            self.isLoadingPhotoLibrary.onNext(false)
            switch result {
            case .success(let data):
                if let data = data as? CleatsDetailsModel {
                    self.message = "success"
                    self.isSuccessPhotoLibrary.onNext(data)
                }
            case .failure(let error):
                self.isLoadingPhotoLibrary.onNext(false)
                if error == .authenticationError {
                    self.message = "please, try to login again"
                }
                let error = ErrorMessage(title: "Error", message: self.message,
                                         action: nil)
                self.isErrorPhotoLibrary.onNext(error)
            }
        }
    }
}
