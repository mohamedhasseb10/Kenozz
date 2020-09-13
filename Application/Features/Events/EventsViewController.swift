//
//  EventsViewController.swift
//  Src
//
//  Created by BobaHasseb on 8/4/20.
//  Copyright © 2020 BobaHasseb. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class EventsViewController: UIViewController, BaseViewController {
    // MARK: - Outlets
    @IBOutlet weak var eventsTableView: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var previousEventsButton: UIButton!
    @IBOutlet weak var commingEventsButton: UIButton!
    // MARK: - RxSwif Variables
    let disposeBag: DisposeBag = DisposeBag()
    let isSuccessTableView = PublishSubject<[EventData]>()
    // MARK: - Variables
    let viewModel = EventsViewModel()
    var previousEvents = [EventData]()
    var commingEvents = [EventData]()
    override func viewDidLoad() {
        super.viewDidLoad()
        regiserNibs()
        setUpBindings()
        setupTableViewBindings()
        setUPButtons()
    }
    override func viewWillAppear(_ animated: Bool) {
        viewModel.getEventData()
        eventsTableView.rowHeight = 164
    }
    // MARK: - RegisterNib
    func regiserNibs() {
        eventsTableView.registerNib(identifier: R.nib.eventTableViewCell.name)
    }
    func setUPButtons() {
        previousEventsButton.roundCorners(radius: 10,
                                          corners: [.layerMinXMinYCorner,
                                                    .layerMinXMaxYCorner])
        commingEventsButton.roundCorners(radius: 10,
                                          corners: [.layerMaxXMaxYCorner,
                                                    .layerMaxXMinYCorner])
    }
    // MARK: - Bindings
    func setUpBindings() {
        viewModel.isLoading
            .observeOn(MainScheduler.instance)
            .bind(to: self.rx.isAnimating)
            .disposed(by: disposeBag)
        viewModel
            .isError
            .observeOn(MainScheduler.instance)
            .bind(to: self.rx.isError)
            .disposed(by: disposeBag)

        viewModel
            .isSuccess.observeOn(MainScheduler.instance)
            .subscribe({ [weak self] (data) in
                guard let self = self else { return }
                guard let items = data.element else { return }
                if let events = items.data {
                    self.previousEvents =
                        self.viewModel.getPreviousEvents(events: events)
                    self.commingEvents = self.viewModel.getCommingEvents(events: events)
                    self.isSuccessTableView.onNext(self.commingEvents)
                }
            }).disposed(by: disposeBag)
    }
    func setupTableViewBindings() {
        self.isSuccessTableView
            .observeOn(MainScheduler.instance)
            .bind(to: eventsTableView
                .rx
                .items(cellIdentifier: R.nib.eventTableViewCell.name,
                       cellType: EventTableViewCell.self)) { (_, item, cell) in
                   cell.itemCell = item
            }.disposed(by: disposeBag)
    }
    // MARK: - Previous Events Pressed
    @IBAction func previousEventsAction(_ sender: Any) {
        previousEventsButton.backgroundColor =
            UIColor(red: 0.07, green: 0.51, blue: 0.72, alpha: 1.00)
        commingEventsButton.backgroundColor = UIColor(red: 0.19, green: 0.19,
        blue: 0.19, alpha: 1.00)
        self.isSuccessTableView.onNext(previousEvents)
    }
    // MARK: - Comming Events Pressed
    @IBAction func commingEventsAction(_ sender: Any) {
        commingEventsButton.backgroundColor =
            UIColor(red: 0.07, green: 0.51, blue: 0.72, alpha: 1.00)
        previousEventsButton.backgroundColor = UIColor(red: 0.19, green: 0.19,
        blue: 0.19, alpha: 1.00)
        viewModel.getEventData()
    }
    // MARK: - Back Button Pressed
    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
