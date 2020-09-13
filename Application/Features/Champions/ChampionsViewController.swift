//
//  ChampionsViewController.swift
//  Src
//
//  Created by BobaHasseb on 9/9/20.
//  Copyright © 2020 BobaHasseb. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ChampionsViewController: UIViewController, BaseViewController {
    // MARK: - Outlets
    @IBOutlet weak var championsTableView: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var latestChampionsButton: UIButton!
    // MARK: - RxSwif Variables
    let disposeBag: DisposeBag = DisposeBag()
    let isSuccessTableView = PublishSubject<[ChampionItem]>()
    // MARK: - Variables
    let viewModel = ChampionsViewModel()
    var latestChampions = [ChampionsData]()
    override func viewDidLoad() {
        super.viewDidLoad()
        regiserNibs()
        setUpBindings()
        setupTableViewBindings()
    }
    override func viewWillAppear(_ animated: Bool) {
        viewModel.getChampionsData()
        championsTableView.rowHeight = 164
    }
    // MARK: - RegisterNib
    func regiserNibs() {
        championsTableView.registerNib(identifier: R.nib.eventTableViewCell.name)
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
                if let champions = items.data?.data {
                    self.isSuccessTableView.onNext(champions)
                }
            }).disposed(by: disposeBag)
    }
    func setupTableViewBindings() {
        self.isSuccessTableView
            .observeOn(MainScheduler.instance)
            .bind(to: championsTableView
                .rx
                .items(cellIdentifier: R.nib.eventTableViewCell.name,
                       cellType: EventTableViewCell.self)) { (_, item, cell) in
                   cell.championCell = item
            }.disposed(by: disposeBag)
    }
    // MARK: - latest Events Pressed
    @IBAction func latestChampionsAction(_ sender: Any) {
      //  self.isSuccessTableView.onNext(previousEvents)
    }
    // MARK: - Back Button Pressed
    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
