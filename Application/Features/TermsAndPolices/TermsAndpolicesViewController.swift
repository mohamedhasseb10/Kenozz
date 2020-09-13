//
//  TermsAndpolicesViewController.swift
//  Src
//
//  Created by BobaHasseb on 8/8/20.
//  Copyright © 2020 BobaHasseb. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class TermsAndpolicesViewController: UIViewController, BaseViewController {
    // MARK: - Outlets
    @IBOutlet weak var policesTextView: UITextView!
    // MARK: - RxSwif Variables
    let disposeBag: DisposeBag = DisposeBag()
    // MARK: - Variables
    let viewModel = TermsAndpolicesViewModel()
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpBindings()
        policesTextView.textContainerInset = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
    }
    override func viewWillAppear(_ animated: Bool) {
        viewModel.getConfigData()
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
                if let polices = items.data?[0].polices_and_condition {
                    self.policesTextView.text = polices
                }
            }).disposed(by: disposeBag)
    }
    // MARK: - Back Button Pressed
    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
