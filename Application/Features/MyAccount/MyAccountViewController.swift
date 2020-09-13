//
//  MyAccountViewController.swift
//  Src
//
//  Created by BobaHasseb on 8/13/20.
//  Copyright © 2020 BobaHasseb. All rights reserved.
//

import UIKit

class MyAccountViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = false
    }
    // MARK: - Favouritte Events Pressed
    @IBAction func myFavouriteAction(_ sender: Any) {
        if let destinationVC = FavouriteViewController.instantiateFromNib() {
            self.navigationController?.pushViewController(destinationVC, animated:
                true)
        }
    }
    // MARK: - About Application Events Pressed
    @IBAction func aboutApplicationAction(_ sender: Any) {
        if let destinationVC = AboutApplicationViewController.instantiateFromNib() {
            self.navigationController?.pushViewController(destinationVC, animated:
                true)
        }
    }
    // MARK: - Polices Events Pressed
    @IBAction func policesAction(_ sender: Any) {
        if let destinationVC = TermsAndpolicesViewController.instantiateFromNib() {
            self.navigationController?.pushViewController(destinationVC, animated:
                true)
        }
    }
    // MARK: - MyOrders Pressed
    @IBAction func myOrdersAction(_ sender: Any) {
        let destinationVC = MyOrdersListViewController.instantiate(fromAppStoryboard: .main)
        self.navigationController?.pushViewController(destinationVC, animated:
            true)
    }
    // MARK: - LogOut Pressed
    @IBAction func logOutAction(_ sender: Any) {
        guard let popUpViewController = LogOutViewController.instantiateFromNib() else {
            return
        }
          let navigationController = UINavigationController(rootViewController:
            popUpViewController)
        navigationController.modalPresentationStyle =
            UIModalPresentationStyle.overCurrentContext
        self.present(navigationController, animated: true, completion: nil)
    }
    // MARK: - LogOut Pressed
    @IBAction func changeLanguageAction(_ sender: Any) {
        guard let popUpViewController =
            ChangeLanguageViewController.instantiateFromNib() else {
            return
        }
          let navigationController = UINavigationController(rootViewController:
            popUpViewController)
        navigationController.modalPresentationStyle =
            UIModalPresentationStyle.overCurrentContext
        self.present(navigationController, animated: true, completion: nil)
    }
}
