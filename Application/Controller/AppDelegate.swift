//
//  AppDelegate.swift
//  Src
//
//  Created by BobaHasseb on 5/4/20.
//  Copyright © 2020 BobaHasseb. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        LocalizationManager.shared.delegate = self
        LocalizationManager.shared.setAppInnitLanguage()
        IQKeyboardManager.shared.enable = true
        return true
    }
}

extension AppDelegate: LocalizationDelegate {
    func resetApp() {
        guard let window = window else { return }
        let vcc = MainPageViewController.instantiateFromNib()
        window.rootViewController = vcc
        let options: UIView.AnimationOptions = .transitionCrossDissolve
        let duration: TimeInterval = 0.3
        UIView.transition(with: window, duration: duration, options: options, animations: nil, completion: nil)
    }
}
