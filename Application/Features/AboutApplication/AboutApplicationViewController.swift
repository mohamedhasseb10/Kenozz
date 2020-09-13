//
//  AboutApplicationViewController.swift
//  Src
//
//  Created by BobaHasseb on 8/14/20.
//  Copyright © 2020 BobaHasseb. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class AboutApplicationViewController: UIViewController, BaseViewController {
    // MARK: - Outlets
    @IBOutlet weak var aboutTextView: UITextView!
    // MARK: - RxSwif Variables
    let disposeBag: DisposeBag = DisposeBag()
    // MARK: - Variables
    let viewModel = TermsAndpolicesViewModel()
    // MARK: - Inits
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpBindings()
        aboutTextView.textContainerInset = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
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
                if let aboutApp = items.data?[0].about_app {
                    self.aboutTextView.text = aboutApp
                }
            }).disposed(by: disposeBag)
    }
    // MARK: - Back Button Pressed
    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
