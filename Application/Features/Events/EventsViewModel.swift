//
//  VideoViewModel.swift
//  Src
//
//  Created by BobaHasseb on 8/3/20.
//  Copyright © 2020 BobaHasseb. All rights reserved.
//

import Foundation
import RxSwift

class EventsViewModel: BaseViewModel {
    // MARK: - RxSwif Variables
    let isSuccess: PublishSubject<EventModel> = PublishSubject()
    let isLoading: PublishSubject<Bool> = PublishSubject()
    let isError: PublishSubject<ErrorMessage> = PublishSubject()
    let disposeBag: DisposeBag = DisposeBag()
    // MARK: - ViewModel Variables
    let repository: EventRepository
    var message = ""
    // MARK: - init
    public init (_ repo: EventRepository = EventRepository()) {
        repository = repo
        isSuccess.disposed(by: disposeBag)
        configureDisposeBag()
    }
    // MARK: - Call Event Api
    func getEventData() {
        self.isLoading.onNext(true)
        repository.getEventData { [weak self] (result) in
            guard let self = self else {
                return
            }
            self.isLoading.onNext(false)
            switch result {
            case .success(let data):
                if let data = data as? EventModel {
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
    func getPreviousEvents(events: [EventData]) -> [EventData] {
        var previousEvents = [EventData]()
        for item in events where item.event_date != nil {
                previousEvents.append(item)
        }
        return previousEvents
    }
    func getCommingEvents(events: [EventData]) -> [EventData] {
        var previousEvents = [EventData]()
        for item in events where item.event_date == nil {
                previousEvents.append(item)
        }
        return previousEvents
    }
}
