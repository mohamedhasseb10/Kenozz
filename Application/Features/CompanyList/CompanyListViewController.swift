//
//  CompanyListViewController.swift
//  Src
//
//  Created by BobaHasseb on 9/13/20.
//  Copyright © 2020 BobaHasseb. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SideMenu

class CompanyListViewController: UIViewController, BaseViewController {
    // MARK: - Outlets
    @IBOutlet weak var companyCollectionView: UICollectionView!
    @IBOutlet weak var titleLabel: UILabel!
    // MARK: - RxSwif Variables
    let disposeBag: DisposeBag = DisposeBag()
    let isSuccessSectionCollectionView =
        PublishSubject<[CompanyListData]>()
    // MARK: - Variables
    let viewModel = CompanyListViewModel()
    var contentId = 0
    var type = ""
    var menu: SideMenuNavigationController?
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        regiserNibs()
        setUpCollectionView()
        setUpCompanyBindings()
        setupCollectionViewBindings()
        bindCollectionViewSelected()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = false
        viewModel.getCompanyListData(idd: contentId)
    }
    // MARK: - RegisterNib
    func regiserNibs() {
        companyCollectionView.registerNib(identifier:
            R.nib.sectionItemCollectionViewCell.name)
    }
    // MARK: - SetUp CollectionViews
    func setUpCollectionView() {
        companyCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
    }
    func setUpCompanyBindings() {
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
                if let sectionItems = items.data {
                    self.isSuccessSectionCollectionView.onNext(sectionItems)
                }
            }).disposed(by: disposeBag)
    }
        func setupCollectionViewBindings() {
            self.isSuccessSectionCollectionView
                .observeOn(MainScheduler.instance)
                .bind(to: companyCollectionView
                    .rx
                    .items(cellIdentifier: R.nib.sectionItemCollectionViewCell.name,
                           cellType: SectionItemCollectionViewCell.self)) { (_, item, cell) in
                       cell.companyCell = item
                }.disposed(by: disposeBag)
    }
    private func bindCollectionViewSelected() {
                Observable
                        .zip(
                            companyCollectionView
                                .rx
                                .itemSelected, companyCollectionView
                                .rx
                                .modelSelected(CompanyListData.self)
                        )
                        .bind { [weak self] _, model in
                            guard let self = self else { return }
                            if self.type == "FAMOUS" {
                                if let destinationVC =
                                   TheFamousViewController.instantiateFromNib() {
                                    destinationVC.contentId =  model.id ?? 0
                                    destinationVC.contentId = 1
                                    destinationVC.titleLabel.text = model.name
                                   self.navigationController?.pushViewController(destinationVC, animated: true)
                                }
                            } else if self.type == "PHOTOGRAPHER" {
                                if let destinationVC =
                                   PhotoListViewController.instantiateFromNib() {
                                    destinationVC.contentId =  model.id ?? 0
                                    destinationVC.contentId = 1
                                    destinationVC.titleLabel.text = model.name
                                   self.navigationController?.pushViewController(destinationVC, animated: true)
                                }
                            } else {
                                if let destinationVC =
                                   SellerViewController.instantiateFromNib() {
                                    destinationVC.contentId =  model.id ?? 0
                                    destinationVC.titleLabel.text = model.name
                                   self.navigationController?.pushViewController(destinationVC, animated: true)
                                }
                            }
                }.disposed(by: disposeBag)
    }
    // MARK: - Menu Tapped
    @IBAction func toogleMenuTapped(_ sender: Any) {
        if let menu = self.menu {
            present(menu, animated: true, completion: nil)
        }
    }
    // MARK: - Back Button Pressed
    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension CompanyListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == companyCollectionView {
            return CGSize(width:
            (companyCollectionView.frame.width - 30) / 3.0, height: 118)
        }
        return CGSize(width: 88, height: 142)
    }
}
