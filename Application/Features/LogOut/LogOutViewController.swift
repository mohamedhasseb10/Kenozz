//
//  LogOutViewController.swift
//  Src
//
//  Created by BobaHasseb on 8/25/20.
//  Copyright © 2020 BobaHasseb. All rights reserved.
//

import UIKit

class LogOutViewController: UIViewController {
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.init(white: 1, alpha: 0.5)
        view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
    }
    override func viewWillAppear(_ animated: Bool) {
         self.navigationController?.navigationBar.isHidden = true
     }
    // MARK: - Accept Button Action
    @IBAction func acceptButtonTapped(_ sender: Any) {
        if let destinationVC = LoginViewController.instantiateFromNib() {
            navigateToNavigationController(using: destinationVC)
        }
    }
    // MARK: - Set refuse Button Action
    @IBAction func refuseButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    func navigateToNavigationController(using controller: UIViewController) {
        let navController = UINavigationController(rootViewController: controller)
        UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController
            = navController
        }
}
