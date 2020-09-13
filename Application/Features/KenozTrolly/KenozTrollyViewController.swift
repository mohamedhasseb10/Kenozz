//
//  KenozTrollyViewController.swift
//  Src
//
//  Created by BobaHasseb on 8/1/20.
//  Copyright © 2020 BobaHasseb. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SideMenu

class KenozTrollyViewController: UIViewController, BaseViewController {
    // MARK: - Outlets
    @IBOutlet weak var horsesCollectionView: UICollectionView!
    @IBOutlet weak var companyCollectionView: UICollectionView!
    @IBOutlet weak var famousCollectionView: UICollectionView!
    @IBOutlet weak var photoGrapherCollectionView: UICollectionView!
    @IBOutlet weak var allProductsCollectionView: UICollectionView!
    @IBOutlet weak var companyButton: UIButton!
    @IBOutlet weak var famousButton: UIButton!
    @IBOutlet weak var photoGraphersButton: UIButton!
    @IBOutlet weak var allProductsButton: UIButton!
    @IBOutlet weak var pageController: UIPageControl!
    // MARK: - RxSwif Variables
    let disposeBag: DisposeBag = DisposeBag()
    let isSuccessPageControlCollectionView =
        PublishSubject<[KenozTrollySliderData]>()
    let isSuccessSectionsCollectionView =
        PublishSubject<[GeneralSectionsData]>()
    let isSuccessFamousCollectionView =
        PublishSubject<[GeneralSectionsData]>()
    let isSuccessPhotoGrapherCollectionView =
        PublishSubject<[GeneralSectionsData]>()
    let isSuccessAllProductsCollectionView =
        PublishSubject<[ProductItem]>()
    // MARK: - Variables
    let viewModel = KenozTrollyViewModel()
    var menu: SideMenuNavigationController?
    var timer = Timer()
    var counter = 0
    var numberOfPageControll = 0
    var userDefaults = UserDefaults.standard
    var list = [GeneralSectionsData?]()
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSideMenu()
        regiserNibs()
        setUpCollectionView()
        setUpPageController()
        setUPButtons()
        setUpSliderBindings()
        setUpSellerBindings()
        setUpProductsBindings()
        setupCollectionViewBindings()
        bindCompanyCollectionViewSelected()
        bindFamousCollectionViewSelected()
        bindPhotoGrapherCollectionViewSelected()
        viewModel.getSliderData()
        viewModel.getSectionsData(idd: 8)
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = false
        tabBarItem.title = "الشركات"
        tabBarItem.image = UIImage()
        tabBarItem.badgeColor = .red
        if let badgeValue = userDefaults.badgeValue {
            if badgeValue != "0" {
                tabBarController?.tabBar.items?[3].badgeValue = badgeValue
            }
        }
    }
    // MARK: - SetUp side menu
    func setUpSideMenu() {
        let sideMenu = SideMenuViewController.instantiate(fromAppStoryboard: .main)
        menu = SideMenuNavigationController(rootViewController: sideMenu)
        menu?.leftSide = false
        menu?.statusBarEndAlpha = 0
        menu?.settings.menuWidth = self.view.frame.width - 80
        menu?.settings.presentationStyle.menuStartAlpha = 1
    }
    // MARK: - RegisterNib
    func regiserNibs() {
        horsesCollectionView.registerNib(identifier: R.nib.pageControllerCollectionViewCell.name)
        companyCollectionView.registerNib(identifier:
            R.nib.generalSectionsCollectionViewCell.name)
        allProductsCollectionView.registerNib(identifier:
            R.nib.allProductsCollectionViewCell.name)
        famousCollectionView.registerNib(identifier:
            R.nib.generalSectionsCollectionViewCell.name)
        photoGrapherCollectionView.registerNib(identifier:
            R.nib.generalSectionsCollectionViewCell.name)
    }
    // MARK: - SetUp CollectionViews
    func setUpCollectionView() {
        horsesCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
        companyCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
        famousCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
        photoGrapherCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
        allProductsCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
    }
    func setUpPageController() {
        self.timer = Timer.scheduledTimer(timeInterval: 1.5, target: self,
                                          selector: #selector(self.changeImage),
                                          userInfo: nil, repeats: true)
    }
    func setUPButtons() {
        allProductsButton.roundCorners(radius: 10,
                                          corners: [.layerMinXMinYCorner,
                                                    .layerMinXMaxYCorner])
        companyButton.roundCorners(radius: 10,
                                          corners: [.layerMaxXMaxYCorner,
                                                    .layerMaxXMinYCorner])
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
    func setUpSellerBindings() {
        viewModel.isLoadingCompany
            .observeOn(MainScheduler.instance)
            .bind(to: self.rx.isAnimating)
            .disposed(by: disposeBag)
        viewModel
            .isErrorCompany
            .observeOn(MainScheduler.instance)
            .bind(to: self.rx.isError)
            .disposed(by: disposeBag)

        viewModel
            .isSuccessCompany.observeOn(MainScheduler.instance)
            .subscribe({ [weak self] (data) in
                guard let self = self else { return }
                guard let item = data.element else { return }
                if let items = item.data {
                    self.list = items
                    let company = self.viewModel.filterList(list: items, type:
                        "COMPANY")
                    self.isSuccessSectionsCollectionView.onNext(company)
                }
            }).disposed(by: disposeBag)
    }
    func setUpProductsBindings() {
        viewModel.isLoadingProducts
            .observeOn(MainScheduler.instance)
            .bind(to: self.rx.isAnimating)
            .disposed(by: disposeBag)
        viewModel
            .isErrorProducts
            .observeOn(MainScheduler.instance)
            .bind(to: self.rx.isError)
            .disposed(by: disposeBag)

        viewModel
            .isSuccessProducts.observeOn(MainScheduler.instance)
            .subscribe({ [weak self] (data) in
                guard let self = self else { return }
                guard let items = data.element else { return }
                if let products = items.data?.data {
                    self.isSuccessAllProductsCollectionView.onNext(products)
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
                   cell.itemCell = item
            }.disposed(by: disposeBag)

        self.isSuccessSectionsCollectionView
            .observeOn(MainScheduler.instance)
            .bind(to: companyCollectionView
                .rx
                .items(cellIdentifier: R.nib.generalSectionsCollectionViewCell.name,
                       cellType: GeneralSectionsCollectionViewCell.self)) { (_, item, cell) in
                    cell.itemCell = item
            }.disposed(by: disposeBag)
        
        self.isSuccessFamousCollectionView
            .observeOn(MainScheduler.instance)
            .bind(to: famousCollectionView
                .rx
                .items(cellIdentifier: R.nib.generalSectionsCollectionViewCell.name,
                       cellType: GeneralSectionsCollectionViewCell.self)) { (_, item, cell) in
                    cell.itemCell = item
            }.disposed(by: disposeBag)
        
        self.isSuccessPhotoGrapherCollectionView
            .observeOn(MainScheduler.instance)
            .bind(to: photoGrapherCollectionView
                .rx
                .items(cellIdentifier: R.nib.generalSectionsCollectionViewCell.name,
                       cellType: GeneralSectionsCollectionViewCell.self)) { (_, item, cell) in
                        print(item)
                    cell.itemCell = item
            }.disposed(by: disposeBag)
        
        self.isSuccessAllProductsCollectionView
            .observeOn(MainScheduler.instance)
            .bind(to: allProductsCollectionView
                .rx
                .items(cellIdentifier: R.nib.allProductsCollectionViewCell.name,
                       cellType: AllProductsCollectionViewCell.self)) { (_, item,
                        cell) in
                    cell.itemCell = item
            }.disposed(by: disposeBag)
    }
    private func bindCompanyCollectionViewSelected() {
         Observable
                 .zip(
                     companyCollectionView
                         .rx
                         .itemSelected, companyCollectionView
                         .rx
                         .modelSelected(GeneralSectionsData.self)
                 )
                 .bind { [weak self] _, model in
                     guard let self = self else { return }
                    if model.type == "الخيل" {
                        if let destinationVC =
                           SectionsViewController.instantiateFromNib() {
                           destinationVC.contentId =  model.id ?? 0
                           self.navigationController?.pushViewController(destinationVC, animated: true)
                        }
                    } else {
                        if let destinationVC =
                           CompanyListViewController.instantiateFromNib() {
                           destinationVC.contentId =  model.id ?? 0
                           destinationVC.titleLabel.text = model.type
                           self.navigationController?.pushViewController(destinationVC, animated: true)
                        }
                    }
         }.disposed(by: disposeBag)
    }
    private func bindFamousCollectionViewSelected() {
         Observable
                 .zip(
                     famousCollectionView
                         .rx
                         .itemSelected, famousCollectionView
                         .rx
                         .modelSelected(GeneralSectionsData.self)
                 )
                 .bind { [weak self] _, model in
                     guard let self = self else { return }
                     if let destinationVC =
                        CompanyListViewController.instantiateFromNib() {
                        destinationVC.contentId =  model.id ?? 0
                        destinationVC.type = "FAMOUS"
                        destinationVC.titleLabel.text = model.type
                        self.navigationController?.pushViewController(destinationVC, animated: true)
                     }}.disposed(by: disposeBag)
    }
    private func bindPhotoGrapherCollectionViewSelected() {
         Observable
                 .zip(
                     photoGrapherCollectionView
                         .rx
                         .itemSelected, photoGrapherCollectionView
                         .rx
                         .modelSelected(GeneralSectionsData.self)
                 )
                 .bind { [weak self] _, model in
                     guard let self = self else { return }
                     if let destinationVC =
                        CompanyListViewController.instantiateFromNib() {
                        destinationVC.contentId =  model.id ?? 0
                        destinationVC.type = "PHOTOGRAPHER"
                        destinationVC.titleLabel.text = model.type
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
    // MARK: - Company Events Pressed
    @IBAction func companyAction(_ sender: Any) {
        companyButton.backgroundColor =
            UIColor(red: 0.07, green: 0.51, blue: 0.72, alpha: 1.00)
        famousButton.backgroundColor = UIColor(red: 0.19, green: 0.19,
        blue: 0.19, alpha: 1.00)
        photoGraphersButton.backgroundColor = UIColor(red: 0.19, green: 0.19,
        blue: 0.19, alpha: 1.00)
        allProductsButton.backgroundColor = UIColor(red: 0.19, green: 0.19,
        blue: 0.19, alpha: 1.00)
        horsesCollectionView.isHidden = false
        companyCollectionView.isHidden = false
        pageController.isHidden = false
        allProductsCollectionView.isHidden = true
        famousCollectionView.isHidden = true
        photoGrapherCollectionView.isHidden = true
        let company = viewModel.filterList(list: list, type: "COMPANY")
        self.isSuccessSectionsCollectionView.onNext(company)
    }
    // MARK: - Famous Events Pressed
    @IBAction func famousAction(_ sender: Any) {
        famousButton.backgroundColor =
            UIColor(red: 0.07, green: 0.51, blue: 0.72, alpha: 1.00)
        companyButton.backgroundColor = UIColor(red: 0.19, green: 0.19,
        blue: 0.19, alpha: 1.00)
        photoGraphersButton.backgroundColor = UIColor(red: 0.19, green: 0.19,
        blue: 0.19, alpha: 1.00)
        allProductsButton.backgroundColor = UIColor(red: 0.19, green: 0.19,
        blue: 0.19, alpha: 1.00)
        horsesCollectionView.isHidden = false
        famousCollectionView.isHidden = false
        pageController.isHidden = false
        companyCollectionView.isHidden = true
        photoGrapherCollectionView.isHidden = true
        allProductsCollectionView.isHidden = true
        let famous = viewModel.filterList(list: list, type: "FAMOUS")
        self.isSuccessFamousCollectionView.onNext(famous)
    }
    // MARK: - photoGraphers Events Pressed
    @IBAction func photoGraphersAction(_ sender: Any) {
        photoGraphersButton.backgroundColor =
            UIColor(red: 0.07, green: 0.51, blue: 0.72, alpha: 1.00)
        companyButton.backgroundColor = UIColor(red: 0.19, green: 0.19,
        blue: 0.19, alpha: 1.00)
        famousButton.backgroundColor = UIColor(red: 0.19, green: 0.19,
        blue: 0.19, alpha: 1.00)
        allProductsButton.backgroundColor = UIColor(red: 0.19, green: 0.19,
        blue: 0.19, alpha: 1.00)
        horsesCollectionView.isHidden = false
        photoGrapherCollectionView.isHidden = false
        pageController.isHidden = false
        companyCollectionView.isHidden = true
        famousCollectionView.isHidden = true
        allProductsCollectionView.isHidden = true
        let photoGrapher = viewModel.filterList(list: list, type: "PHOTOGRAPHER")
        print(photoGrapher)
        self.isSuccessPhotoGrapherCollectionView.onNext(photoGrapher)
    }

    // MARK: - All Products Events Pressed
    @IBAction func allProductsAction(_ sender: Any) {
        allProductsButton.backgroundColor =
            UIColor(red: 0.07, green: 0.51, blue: 0.72, alpha: 1.00)
        companyButton.backgroundColor = UIColor(red: 0.19, green: 0.19,
        blue: 0.19, alpha: 1.00)
        photoGraphersButton.backgroundColor = UIColor(red: 0.19, green: 0.19,
        blue: 0.19, alpha: 1.00)
        famousButton.backgroundColor = UIColor(red: 0.19, green: 0.19,
        blue: 0.19, alpha: 1.00)
        horsesCollectionView.isHidden = true
        companyCollectionView.isHidden = true
        photoGrapherCollectionView.isHidden = true
        famousCollectionView.isHidden = true
        pageController.isHidden = true
        allProductsCollectionView.isHidden = false
        viewModel.allProductsData()
    }
    // MARK: - Menu Tapped
    @IBAction func toogleMenuTapped(_ sender: Any) {
        if let menu = self.menu {
            present(menu, animated: true, completion: nil)
        }
    }
}
extension KenozTrollyViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == horsesCollectionView {
            return CGSize(width: horsesCollectionView.frame.size.width,
                          height: horsesCollectionView.frame.size.height)
        } else if collectionView == companyCollectionView {
            return CGSize(width:
            (companyCollectionView.frame.width - 30) / 3.0, height: 118)
        } else if collectionView == famousCollectionView {
            return CGSize(width:
            (companyCollectionView.frame.width - 30) / 3.0, height: 118)
        } else if collectionView == photoGrapherCollectionView {
            return CGSize(width:
            (companyCollectionView.frame.width - 30) / 3.0, height: 118)
        } else if collectionView == allProductsCollectionView {
            return CGSize(width:
            (allProductsCollectionView.frame.width - 30) / 3.0, height: 145)
        } 
        return CGSize(width: 88, height: 142)
    }
}
