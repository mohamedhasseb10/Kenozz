//
//  KenozMagazinViewModel.swift
//  Src
//
//  Created by BobaHasseb on 8/5/20.
//  Copyright © 2020 BobaHasseb. All rights reserved.
//

import Foundation
import RxSwift

class KenozMagazineViewModel: BaseViewModel {

    // MARK: - RxSwif Variables
    let isSuccessSlider: PublishSubject<KenozMagazineModel> = PublishSubject()
    let isLoadingSlider: PublishSubject<Bool> = PublishSubject()
    let isErrorSlider: PublishSubject<ErrorMessage> = PublishSubject()
    let isSuccessNews: PublishSubject<NewsModel> = PublishSubject()
    let isLoadingNews: PublishSubject<Bool> = PublishSubject()
    let isErrorNews: PublishSubject<ErrorMessage> = PublishSubject()
    let isSuccessCleats: PublishSubject<HorseCleatsModel> = PublishSubject()
    let isLoadingCleats: PublishSubject<Bool> = PublishSubject()
    let isErrorCleats: PublishSubject<ErrorMessage> = PublishSubject()
    var isLoading: PublishSubject<Bool>  = PublishSubject()
    var isError: PublishSubject<ErrorMessage> = PublishSubject()
    let disposeBag: DisposeBag = DisposeBag()
    // MARK: - ViewModel Variables
    let repository: KenozMagazineRepository
    var message = ""
    // MARK: - init
    public init (_ repo: KenozMagazineRepository = KenozMagazineRepository()) {
        repository = repo
        isSuccessSlider.disposed(by: disposeBag)
        configureDisposeBag()
    }
    // MARK: - Call home Api
    func getKenozMagazineData() {
        self.isLoadingSlider.onNext(true)
        repository.getMagazineSliderData { [weak self] (result) in
            guard let self = self else {
                return
            }
            self.isLoadingSlider.onNext(false)
            switch result {
            case .success(let data):
                if let data = data as? KenozMagazineModel {
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
    // MARK: - Call News Api
     func getNewsData() {
         self.isLoadingNews.onNext(true)
         repository.getNewsData { [weak self] (result) in
             guard let self = self else {
                 return
             }
             self.isLoadingNews.onNext(false)
             switch result {
             case .success(let data):
                 if let data = data as? NewsModel {
                     self.message = "success"
                     self.isSuccessNews.onNext(data)
                 }
             case .failure(let error):
                 self.isLoadingNews.onNext(false)
                 if error == .authenticationError {
                     self.message = "please, try to login again"
                 }
                 let error = ErrorMessage(title: "Error", message: self.message,
                                          action: nil)
                 self.isErrorNews.onNext(error)
             }
         }
     }
    // MARK: - Call home Api
    func getHorseCleatsData() {
        self.isLoadingCleats.onNext(true)
        repository.getHorseCleatsData { [weak self] (result) in
            guard let self = self else {
                return
            }
            self.isLoadingCleats.onNext(false)
            switch result {
            case .success(let data):
                if let data = data as? HorseCleatsModel {
                    self.message = "success"
                    self.isSuccessCleats.onNext(data)
                }
            case .failure(let error):
                self.isLoadingCleats.onNext(false)
                if error == .authenticationError {
                    self.message = "please, try to login again"
                }
                let error = ErrorMessage(title: "Error", message: self.message,
                                         action: nil)
                self.isErrorCleats.onNext(error)
            }
        }
    }
}
