//
//  CleatsDetailsViewController.swift
//  Src
//
//  Created by BobaHasseb on 8/1/20.
//  Copyright © 2020 BobaHasseb. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class CleatsDetailsViewController: UIViewController, BaseViewController {
    // MARK: - Outlets
    @IBOutlet weak var horsesCollectionView: UICollectionView!
    @IBOutlet weak var photoLibraryCollectionView: UICollectionView!
    @IBOutlet weak var cleatsInformationButton: UIButton!
    @IBOutlet weak var photoLibraryButton: UIButton!
    @IBOutlet weak var mapButton: UIButton!
    @IBOutlet weak var cleatsInformationView: UIView!
    @IBOutlet weak var mapImage: UIImageView!
    @IBOutlet weak var pageController: UIPageControl!
    // MARK: - RxSwif Variables
    let disposeBag: DisposeBag = DisposeBag()
    let isSuccessPageControlCollectionView =
        PublishSubject<[CleatsDetailsData]>()
    let isSuccessPhotoLibraryCollectionView =
        PublishSubject<[CleatsDetailsData]>()
    // MARK: - Variables
    let viewModel = CleatsDetailsViewModel()
    var contentId = 0
    var timer = Timer()
    var counter = 0
    var numberOfPageControll = 0
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        regiserNibs()
        setUpCollectionView()
        setUpPageController()
        setUPButtons()
        setUpSliderBindings()
        setUpPhotoLibraryBindings()
        setupCollectionViewBindings()
    }
    override func viewWillAppear(_ animated: Bool) {
        viewModel.getCleatsDetailsSlider(idd: contentId, type: 1)
    }
    // MARK: - RegisterNib
    func regiserNibs() {
        horsesCollectionView.registerNib(identifier: R.nib.pageControllerCollectionViewCell.name)
        photoLibraryCollectionView.registerNib(identifier:
            R.nib.photoLibraryCollectionViewCell.name)
    }
    // MARK: - SetUp CollectionViews
    func setUpCollectionView() {
        horsesCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
        photoLibraryCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
    }
    func setUpPageController() {
        self.timer = Timer.scheduledTimer(timeInterval: 1.5, target: self,
                                          selector: #selector(self.changeImage),
                                          userInfo: nil, repeats: true)
    }
    func setUPButtons() {
        mapButton.roundCorners(radius: 10,
                                          corners: [.layerMinXMinYCorner,
                                                    .layerMinXMaxYCorner])
        cleatsInformationButton.roundCorners(radius: 10,
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
    func setUpPhotoLibraryBindings() {
        viewModel.isLoadingPhotoLibrary
            .observeOn(MainScheduler.instance)
            .bind(to: self.rx.isAnimating)
            .disposed(by: disposeBag)
        viewModel
            .isErrorPhotoLibrary
            .observeOn(MainScheduler.instance)
            .bind(to: self.rx.isError)
            .disposed(by: disposeBag)

        viewModel
            .isSuccessPhotoLibrary.observeOn(MainScheduler.instance)
            .subscribe({ [weak self] (data) in
                guard let self = self else { return }
                guard let items = data.element else { return }
                if let photoLibrary = items.data {
                    self.isSuccessPhotoLibraryCollectionView.onNext(photoLibrary)
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
                   cell.cleatsDetailsItemCell = item
            }.disposed(by: disposeBag)

        self.isSuccessPhotoLibraryCollectionView
            .observeOn(MainScheduler.instance)
            .bind(to: photoLibraryCollectionView
                .rx
                .items(cellIdentifier: R.nib.photoLibraryCollectionViewCell.name,
                       cellType: PhotoLibraryCollectionViewCell.self)) { (_, item, cell) in
                    cell.itemCell = item
            }.disposed(by: disposeBag)
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
    // MARK: - information Events Pressed
    @IBAction func cleatsInformationAction(_ sender: Any) {
        cleatsInformationButton.backgroundColor =
            UIColor(red: 0.07, green: 0.51, blue: 0.72, alpha: 1.00)
        photoLibraryButton.backgroundColor = UIColor(red: 0.19, green: 0.19,
        blue: 0.19, alpha: 1.00)
        mapButton.backgroundColor = UIColor(red: 0.19, green: 0.19,
        blue: 0.19, alpha: 1.00)
        photoLibraryCollectionView.isHidden = true
        mapImage.isHidden = true
        cleatsInformationView.isHidden = false
    }
    // MARK: - map Events Pressed
    @IBAction func mapAction(_ sender: Any) {
        mapButton.backgroundColor =
            UIColor(red: 0.07, green: 0.51, blue: 0.72, alpha: 1.00)
        photoLibraryButton.backgroundColor = UIColor(red: 0.19, green: 0.19,
        blue: 0.19, alpha: 1.00)
        cleatsInformationButton.backgroundColor = UIColor(red: 0.19, green: 0.19,
        blue: 0.19, alpha: 1.00)
        photoLibraryCollectionView.isHidden = true
        mapImage.isHidden = false
        cleatsInformationView.isHidden = true
    }
    // MARK: - Photo Library Events Pressed
    @IBAction func photoLibraryAction(_ sender: Any) {
        photoLibraryButton.backgroundColor =
            UIColor(red: 0.07, green: 0.51, blue: 0.72, alpha: 1.00)
        mapButton.backgroundColor = UIColor(red: 0.19, green: 0.19,
        blue: 0.19, alpha: 1.00)
        cleatsInformationButton.backgroundColor = UIColor(red: 0.19, green: 0.19,
        blue: 0.19, alpha: 1.00)
        photoLibraryCollectionView.isHidden = false
        mapImage.isHidden = true
        cleatsInformationView.isHidden = true
        viewModel.getCleatsDetailsLibraryImages(idd: contentId, type: 2)
    }
    // MARK: - Back Button Pressed
    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
extension CleatsDetailsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == horsesCollectionView {
            return CGSize(width: horsesCollectionView.frame.size.width,
                          height: horsesCollectionView.frame.size.height)
        } else {
            return CGSize(width: (photoLibraryCollectionView.frame.width - 20) / 3.0, height: 80)
        }
    }
}
