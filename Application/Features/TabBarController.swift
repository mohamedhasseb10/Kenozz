//
//  TabBarController.swift
//  We
//
//  Created by BobaHasseb on 11/11/19.
//  Copyright © 2019 BobaHasseb. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    // MARK: - Inner Types
    var type: HomeType = .kinozMagazine
    private struct Constants {
        static let actionButtonSize = CGSize(width: 60, height: 60)
    }
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        setupConstraints()
        setupApperence()
        if type == .kinozTrolley {
            self.selectedIndex = 2
        } else {
            self.selectedIndex = 0
        }
    }
    // MARK: - Properties
    // MARK: Immutable
    private let sellerActionButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        let image = R.image.homes()
        button.setBackgroundImage(image, for: .normal)
        button.layer.cornerRadius = Constants.actionButtonSize.height/2
        return button
    }()
    // MARK: - Setups
    private func setupApperence() {
        tabBar.barTintColor = .black
        UITabBar.appearance().tintColor =
            UIColor(red: 0.07, green: 0.51, blue: 0.72, alpha: 1.00)
        UITabBarItem.appearance()
            .setTitleTextAttributes(
                [NSAttributedString.Key.foregroundColor:
                    UIColor(red: 0.07, green: 0.51, blue: 0.72, alpha: 1.00)],
                for: .selected)
        UITabBarItem.appearance()
            .setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
    }
    private func setupSubviews() {
        createTabbarControllers()
        if type == .kinozTrolley {
            tabBar.addSubview(sellerActionButton)
        }
    }
    private func setupConstraints() {
        if type == .kinozTrolley {
        tabBar.centerXAnchor.constraint(equalTo:
            sellerActionButton.centerXAnchor).isActive = true
        tabBar.topAnchor.constraint(equalTo:
            sellerActionButton.centerYAnchor).isActive = true
        sellerActionButton.widthAnchor.constraint(equalToConstant:
            Constants.actionButtonSize.width).isActive = true
        sellerActionButton.heightAnchor.constraint(equalToConstant:
            Constants.actionButtonSize.height).isActive = true
        }
    }

    // MARK: - Helpers

    private func createTabbarControllers() {
        switch type {
        case .kinozMagazine:
            creatKenozMagazineControllers()
        default:
            creatKenozTrollyControllers()
        }
    }

    private func creatKenozMagazineControllers() {
        var systemTags = [RoundedTabBarItem]()
        systemTags = [.news, .video, .kenozTrolly, .horseCleats]
        let viewControllers = systemTags.compactMap { self.createController(for: $0, with: $0.tag) }
        self.viewControllers = viewControllers
    }

    private func creatKenozTrollyControllers() {
        var systemTags = [RoundedTabBarItem]()
        systemTags = [.myAcountItem, .favouriteItem, .sellersItem,
                      .cartItem, .kenozMagazineItem]
        let viewControllers = systemTags.compactMap { self.createController(for: $0, with: $0.tag) }

        self.viewControllers = viewControllers
    }
    private func createController(for customTabBarItem: RoundedTabBarItem, with tag: Int) -> UINavigationController? {
        let viewController = getController(forItem: customTabBarItem)
        viewController.tabBarItem = customTabBarItem.tabBarItem
        let nav = UINavigationController(rootViewController: viewController)
        nav.navigationBar.isHidden = true
        return nav
    }
    func getController(forItem: RoundedTabBarItem) -> UIViewController {
        var viewController = UIViewController()
        switch forItem {
        case .myAcountItem:
            viewController = myAccountController()
        case .favouriteItem:
            viewController = favouriteController()
        case .sellersItem:
            viewController = kenozTrollyController()
        case .cartItem:
            viewController = cartController()
        case .kenozMagazineItem:
            viewController = UIViewController()
        case .news:
            viewController = newsController()
        case .video:
            viewController = videoController()
        case .kenozTrolly:
            viewController = UIViewController()
        case .horseCleats:
            viewController = horseCleatsController()
        }
        return viewController
    }
}

extension TabBarController {
    func kenozMagazineController() -> UIViewController {
        guard let kenozMagazine = KenozMagazineViewController.instantiateFromNib()
            else { return UIViewController() }
        return kenozMagazine
    }
    func kenozTrollyController() -> UIViewController {
        guard let kenozTrolly = KenozTrollyViewController.instantiateFromNib()
            else { return UIViewController() }
        return kenozTrolly
    }
    func horseCleatsController() -> UIViewController {
        guard let horseCleats = HorsesCleatsViewController.instantiateFromNib()
            else { return UIViewController() }
        return horseCleats
    }
    func newsController() -> UIViewController {
        guard let news = NewsViewController.instantiateFromNib()
            else { return UIViewController() }
        return news
    }
    func videoController() -> UIViewController {
        guard let video = VideoViewController.instantiateFromNib()
            else { return UIViewController() }
        return video
    }
    func favouriteController() -> UIViewController {
        guard let favourite = FavouriteViewController.instantiateFromNib()
            else { return UIViewController() }
        return favourite
    }
    func myAccountController() -> UIViewController {
        guard let myAccount = MyAccountViewController.instantiateFromNib()
            else { return UIViewController() }
        return myAccount
    }
    func cartController() -> UIViewController {
        let cart = CartViewController.instantiate(fromAppStoryboard: .main)
        return cart
    }
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if item.tag == 8 {
            let kenozTrolly = TabBarController.instantiate(fromAppStoryboard:
                .main)
            kenozTrolly.type = .kinozTrolley
            navigate(to: kenozTrolly)
        } else if item.tag == 5 {
            let kenozMagazine = TabBarController.instantiate(fromAppStoryboard:
                .main)
            kenozMagazine.type = .kinozMagazine
            navigate(to: kenozMagazine)
        }
    }
    // MARK: - Navigation
    func navigate(to controller: UIViewController) {
        UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController
            = controller
        }
}
enum HomeType {
    case kinozTrolley
    case kinozMagazine
}
