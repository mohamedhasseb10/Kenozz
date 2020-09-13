//
//  KenozMagazineViewController.swift
//  Src
//
//  Created by BobaHasseb on 8/1/20.
//  Copyright © 2020 BobaHasseb. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SideMenu

class KenozMagazineViewController: UIViewController, BaseViewController {
    // MARK: - Outlets
    @IBOutlet weak var horsesCollectionView: UICollectionView!
    @IBOutlet weak var cleatsCollectionView: UICollectionView!
    @IBOutlet weak var recentNewsCollectionView: UICollectionView!
    @IBOutlet weak var cleatsButton: UIButton!
    @IBOutlet weak var recentNewsButton: UIButton!
    @IBOutlet weak var pageController: UIPageControl!
    // MARK: - RxSwif Variables
    let disposeBag: DisposeBag = DisposeBag()
    let isSuccessPageControlCollectionView = PublishSubject<[KenozMagazineData]>()
    let isSuccessCleatsCollectionView = PublishSubject<[HorseCleatsData]>()
    let isSuccessRecentNewsCollectionView = PublishSubject<[NewsItem]>()
    // MARK: - Variables
    let viewModel = KenozMagazineViewModel()
    var menu: SideMenuNavigationController?
    var timer = Timer()
    var counter = 0
    var numberOfPageControll = 0
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSideMenu()
        regiserNibs()
        setUpCollectionView()
        setUpPageController()
        setUpSliderBindings()
        setUpNewsBindings()
        setUpCleatsBindings()
        setupCollectionViewBindings()
        bindCollectionViewSelected()
    }
    override func viewWillAppear(_ animated: Bool) {
        tabBarItem.title = "الرئيسية"
        tabBarItem.image = UIImage()
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = false
        viewModel.getKenozMagazineData()
        viewModel.getHorseCleatsData()
        viewModel.getNewsData()
    }
    // MARK: - SetUp side menu
    func setUpSideMenu() {
        let sideMenu = SideMenuViewController.instantiate(fromAppStoryboard: .main)
        menu = SideMenuNavigationController(rootViewController: sideMenu)
        menu?.leftSide = false
        menu?.statusBarEndAlpha = 0
        menu?.settings.presentationStyle.menuStartAlpha = 1
    }
    // MARK: - RegisterNib
    func regiserNibs() {
        horsesCollectionView.registerNib(identifier: R.nib.pageControllerCollectionViewCell.name)
        cleatsCollectionView.registerNib(identifier:
            R.nib.horsesCleatsCollectionViewCell.name)
        recentNewsCollectionView.registerNib(identifier:
            R.nib.latestNewsCollectionViewCell.name)
    }
    // MARK: - SetUp CollectionViews
    func setUpCollectionView() {
        horsesCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
        cleatsCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
        recentNewsCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
    }
    func setUpPageController() {
        self.timer = Timer.scheduledTimer(timeInterval: 1.5, target: self,
                                          selector: #selector(self.changeImage),
                                          userInfo: nil, repeats: true)
    }
    // MARK: - Bindings
    func setUpSliderBindings() {
        viewModel.isLoadingSlider
            .observeOn(MainScheduler.instance)
            .bind(to: self.rx.isAnimating)
            .disposed(by: disposeBag)
        viewModel
            .isErrorSlider
            .observeOn(MainScheduler.instance)
            .bind(to: self.rx.isError)
            .disposed(by: disposeBag)

        viewModel
            .isSuccessSlider.observeOn(MainScheduler.instance)
            .subscribe({ [weak self] (data) in
                guard let self = self else { return }
                guard let items = data.element else { return }
                if let horses = items.data {
                    self.isSuccessPageControlCollectionView.onNext(horses)
                    self.numberOfPageControll = horses.count
                    self.pageController.numberOfPages = self.numberOfPageControll
                }
            }).disposed(by: disposeBag)
    }
    func setUpCleatsBindings() {
        viewModel.isLoadingCleats
            .observeOn(MainScheduler.instance)
            .bind(to: self.rx.isAnimating)
            .disposed(by: disposeBag)
        viewModel
            .isErrorCleats
            .observeOn(MainScheduler.instance)
            .bind(to: self.rx.isError)
            .disposed(by: disposeBag)

        viewModel
            .isSuccessCleats.observeOn(MainScheduler.instance)
            .subscribe({ [weak self] (data) in
                guard let self = self else { return }
                guard let items = data.element else { return }
                if let cleats = items.data {
                    self.isSuccessCleatsCollectionView.onNext(cleats)
                    self.cleatsButton.isHidden = false
                }
            }).disposed(by: disposeBag)
    }
    func setUpNewsBindings() {
        viewModel.isLoadingNews
            .observeOn(MainScheduler.instance)
            .bind(to: self.rx.isAnimating)
            .disposed(by: disposeBag)
        viewModel
            .isErrorNews
            .observeOn(MainScheduler.instance)
            .bind(to: self.rx.isError)
            .disposed(by: disposeBag)

        viewModel
            .isSuccessNews.observeOn(MainScheduler.instance)
            .subscribe({ [weak self] (data) in
                guard let self = self else { return }
                guard let items = data.element else { return }
                if let news = items.data?.data {
                    self.isSuccessRecentNewsCollectionView.onNext(news)
                    self.recentNewsButton.isHidden = false
                }
            }).disposed(by: disposeBag)
    }
    func setupCollectionViewBindings() {
        self.isSuccessPageControlCollectionView
            .observeOn(MainScheduler.instance)
            .bind(to: horsesCollectionView
                .rx
                .items(cellIdentifier: R.nib.pageControllerCollectionViewCell.name,
                       cellType: PageControllerCollectionViewCell.self)) { (_, item, cell) in
                   cell.kenozMagazineItemCell = item
            }.disposed(by: disposeBag)

        self.isSuccessCleatsCollectionView
            .observeOn(MainScheduler.instance)
            .bind(to: cleatsCollectionView
                .rx
                .items(cellIdentifier: R.nib.horsesCleatsCollectionViewCell.name,
                       cellType: HorsesCleatsCollectionViewCell.self)) { (_, item, cell) in
                    cell.itemCell = item
            }.disposed(by: disposeBag)
        self.isSuccessRecentNewsCollectionView
            .observeOn(MainScheduler.instance)
            .bind(to: recentNewsCollectionView
                .rx
                .items(cellIdentifier: R.nib.latestNewsCollectionViewCell.name,
                       cellType: LatestNewsCollectionViewCell.self)) { (_, item, cell) in
                    cell.itemCell = item
            }.disposed(by: disposeBag)
    }
    private func bindCollectionViewSelected() {
         Observable
                 .zip(
                     recentNewsCollectionView
                         .rx
                         .itemSelected, recentNewsCollectionView
                         .rx
                         .modelSelected(NewsItem.self)
                 )
                 .bind { [weak self] _, model in
                     guard let self = self else { return }
                     if let destinationVC =
                        NewsDetailsViewController.instantiateFromNib() {
                        destinationVC.newsItem =  model
                        self.navigationController?.pushViewController(destinationVC, animated: true)
                     }}.disposed(by: disposeBag)
        Observable
                .zip(
                    cleatsCollectionView
                        .rx
                        .itemSelected, cleatsCollectionView
                        .rx
                        .modelSelected(HorseCleatsData.self)
                )
                .bind { [weak self] _, model in
                    guard let self = self else { return }
                    if let destinationVC =
                       CleatsDetailsViewController.instantiateFromNib() {
                       destinationVC.contentId =  model.id ?? 0
                       self.navigationController?.pushViewController(destinationVC, animated: true)
                    }}.disposed(by: disposeBag)
    }
    @objc func changeImage() {
        if counter < numberOfPageControll {
            let index = IndexPath.init(item: counter, section: 0)
            self.horsesCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            pageController.currentPage = counter
            counter += 1
        } else {
            counter = 0
            let index = IndexPath.init(item: counter, section: 0)
            self.horsesCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: false)
            pageController.currentPage = counter
            counter = 1
        }
    }
    // MARK: - Menu Tapped
    @IBAction func toogleMenuTapped(_ sender: Any) {
        if let menu = self.menu {
            present(menu, animated: true, completion: nil)
        }
    }
}
extension KenozMagazineViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == horsesCollectionView {
            return CGSize(width: horsesCollectionView.frame.size.width,
                          height: horsesCollectionView.frame.size.height)
        } else if collectionView == cleatsCollectionView {
            return CGSize(width:
                (cleatsCollectionView.frame.width - 30) / 3.0, height: 80)
        }
        return CGSize(width:
            (recentNewsCollectionView.frame.width - 30) / 2.5, height: 205)
    }
}
