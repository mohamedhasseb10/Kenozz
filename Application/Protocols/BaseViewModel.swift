//
//  BaseViewModel.swift
//  Src
//
//  Created by xWARE on 5/4/20.
//  Copyright © 2020 xWARE. All rights reserved.
//

import Foundation
import RxSwift

protocol BaseViewModel {
    var isLoading: PublishSubject<Bool> { get }
    var isError: PublishSubject<ErrorMessage> { get }
    var disposeBag: DisposeBag { get }
}
extension BaseViewModel {
    func configureDisposeBag() {
        isError.disposed(by: disposeBag)
        isLoading.disposed(by: disposeBag)
    }
}
protocol BaseViewController {
    var disposeBag: DisposeBag { get }
}
