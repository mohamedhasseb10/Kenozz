//
//  ChampionsViewModel.swift
//  Src
//
//  Created by BobaHasseb on 9/9/20.
//  Copyright © 2020 BobaHasseb. All rights reserved.
//

import Foundation
import RxSwift

class ChampionsViewModel: BaseViewModel {
    // MARK: - RxSwif Variables
    let isSuccess: PublishSubject<ChampionsModel> = PublishSubject()
    let isLoading: PublishSubject<Bool> = PublishSubject()
    let isError: PublishSubject<ErrorMessage> = PublishSubject()
    let disposeBag: DisposeBag = DisposeBag()
    // MARK: - ViewModel Variables
    let repository: ChampionsRepository
    var message = ""
    // MARK: - init
    public init (_ repo: ChampionsRepository = ChampionsRepository()) {
        repository = repo
        isSuccess.disposed(by: disposeBag)
        configureDisposeBag()
    }
    // MARK: - Call Event Api
    func getChampionsData() {
        self.isLoading.onNext(true)
        repository.getChampionsData { [weak self] (result) in
            guard let self = self else {
                return
            }
            self.isLoading.onNext(false)
            switch result {
            case .success(let data):
                if let data = data as? ChampionsModel {
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
    // MARK: - ConverteDateToString
    func convertDateToString(for date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let dateConverted = dateFormatter.string(from: date)
        return dateConverted
    }
    // MARK: - GetDayName
    func getDayName(for date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EE"
        let dayInWeek = dateFormatter.string(from: date)
        return dayInWeek
    }
    // MARK: - GetMonthNumber
    func getMonthNumber(for date: Date) -> String {
        let dayOnMonth =  Calendar.current.ordinality(of: .day, in: .month, for: date)
        return "\(dayOnMonth ?? 0 )"
    }
    // MARK: - GetMonthName
    func getMonthName(for date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.setLocalizedDateFormatFromTemplate("MMM")
        return dateFormatter.string(from: date)
    }
    // MARK: - GetYear
    func getYear(for date: Date) -> String {
        let calendar = NSCalendar.init(calendarIdentifier: NSCalendar.Identifier.gregorian)
        let year = (calendar?.component(NSCalendar.Unit.year, from: Date()))
        return "\(year ?? 0 )"
    }
    func getLatestChampions(champions: [ChampionsData]) -> [ChampionsData] {
        let latestChampions = [ChampionsData]()
        return latestChampions
    }
}
