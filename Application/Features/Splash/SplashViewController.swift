//
//  SplashViewController.swift
//  Src
//
//  Created by BobaHasseb on 8/2/20.
//  Copyright © 2020 BobaHasseb. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {
    // MARK: - Controller Variables
    var userDefaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewDidAppear(_ animated: Bool) {
        let action: (Timer) -> Void = { [weak self] timer in
            guard self != nil else {
                return
            }
            self?.configureSplash()
        }
        Timer.scheduledTimer(withTimeInterval: 3, repeats: false, block: action)
    }
    // MARK: - Configure Splash
    func configureSplash() {
        if userDefaults.isLoggedIn {
            if let destinationVC = MainPageViewController.instantiateFromNib() {
                navigate(to: destinationVC)
            }
        } else {
            if let destinationVC = LoginViewController.instantiateFromNib() {
                navigateToNavigationController(using: destinationVC)
            }
        }
    }
    // MARK: - Navigation
    func navigate(to controller: UIViewController) {
        UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController
            = controller
        }
    func navigateToNavigationController(using controller: UIViewController) {
        let navController = UINavigationController(rootViewController: controller)
        UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController
            = navController
        }
}
