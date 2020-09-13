//
//  KenozTrollyViewModel.swift
//  Src
//
//  Created by BobaHasseb on 8/1/20.
//  Copyright © 2020 BobaHasseb. All rights reserved.
//

import Foundation
import RxSwift

class KenozTrollyViewModel: BaseViewModel {
    // MARK: - RxSwif Variables
    let isSuccessSlider: PublishSubject<KenozTrollySliderModel> = PublishSubject()
    let isLoadingSlider: PublishSubject<Bool> = PublishSubject()
    let isErrorSlider: PublishSubject<ErrorMessage> = PublishSubject()
    let isSuccessProducts: PublishSubject<KenozTrollyProductModel> =
        PublishSubject()
    let isLoadingProducts: PublishSubject<Bool> = PublishSubject()
    let isErrorProducts: PublishSubject<ErrorMessage> = PublishSubject()
    let isSuccessCompany: PublishSubject<GeneralSectionsModel> =
        PublishSubject()
    let isLoadingCompany: PublishSubject<Bool> = PublishSubject()
    let isErrorCompany: PublishSubject<ErrorMessage> = PublishSubject()
    let isLoading: PublishSubject<Bool> = PublishSubject()
    let isError: PublishSubject<ErrorMessage> = PublishSubject()
    let disposeBag: DisposeBag = DisposeBag()
    // MARK: - ViewModel Variables
    let repository: KenozTrollyRepository
    var message = ""
    // MARK: - init
    public init (_ repo: KenozTrollyRepository = KenozTrollyRepository()) {
        repository = repo
        isSuccessSlider.disposed(by: disposeBag)
        configureDisposeBag()
    }
    // MARK: - Call Slider Api
    func getSliderData() {
        self.isLoadingSlider.onNext(true)
        repository.getSliderData { [weak self] (result) in
            guard let self = self else {
                return
            }
            self.isLoadingSlider.onNext(false)
            switch result {
            case .success(let data):
                if let data = data as? KenozTrollySliderModel {
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
    // MARK: - Call All Product Api
    func allProductsData() {
        self.isLoadingProducts.onNext(true)
        repository.getAllProductsData { [weak self] (result) in
            guard let self = self else {
                return
            }
            self.isLoadingProducts.onNext(false)
            switch result {
            case .success(let data):
                if let data = data as? KenozTrollyProductModel {
                    self.message = "success"
                    self.isSuccessProducts.onNext(data)
                }
            case .failure(let error):
                self.isLoadingProducts.onNext(false)
                if error == .authenticationError {
                    self.message = "please, try to login again"
                }
                let error = ErrorMessage(title: "Error", message: self.message,
                                         action: nil)
                self.isErrorProducts.onNext(error)
            }
        }
    }
    // MARK: - Call Company Api
    func getSectionsData(idd: Int) {
        self.isLoadingCompany.onNext(true)
        repository.getSectionsData(idd: idd) { [weak self] (result) in
            guard let self = self else {
                return
            }
            self.isLoadingCompany.onNext(false)
            switch result {
            case .success(let data):
                if let data = data as? GeneralSectionsModel {
                    self.message = "success"
                    self.isSuccessCompany.onNext(data)
                }
            case .failure(let error):
                self.isLoadingCompany.onNext(false)
                if error == .authenticationError {
                    self.message = "please, try to login again"
                }
                let error = ErrorMessage(title: "Error", message: self.message,
                                         action: nil)
                self.isErrorCompany.onNext(error)
            }
        }
    }
    func filterList(list: [GeneralSectionsData?], type: String?) ->
        [GeneralSectionsData] {
            var listFiltered = [GeneralSectionsData]()
            for item in list where item?.cat_type == type {
                if let item = item {
                    listFiltered.append(item)
                }
            }
            return listFiltered
    }
}
