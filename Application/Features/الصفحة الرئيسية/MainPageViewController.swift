//
//  MainPageViewController.swift
//  Src
//
//  Created by BobaHasseb on 7/31/20.
//  Copyright © 2020 BobaHasseb. All rights reserved.
//

import UIKit

class MainPageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    // MARK: - Kenoz Trolly Pressed
    @IBAction func kenozTrollyAction(_ sender: Any) {
        let kenozTrolly = TabBarController.instantiate(fromAppStoryboard: .main)
        kenozTrolly.type = .kinozTrolley
        UIApplication
             .shared
             .windows
             .filter {$0.isKeyWindow}.first?.rootViewController = kenozTrolly
    }
    // MARK: - Kenoz Magazine Pressed
    @IBAction func kenozMagazinAction(_ sender: Any) {
        UIApplication
            .shared
            .windows
            .filter {$0.isKeyWindow}.first?.rootViewController =
            TabBarController.instantiate(fromAppStoryboard: .main)
    }
}
