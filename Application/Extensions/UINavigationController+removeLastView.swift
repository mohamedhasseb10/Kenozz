//
//  UINavigationController+removeLastView.swift
//  MagixConcierge
//
//  Created by BobaHasseb on 3/15/20.
//  Copyright © 2020 BobaHasseb. All rights reserved.
//

import UIKit

extension UINavigationController {
    func removeLastViewController() {
        var navigationArray = self.viewControllers // To get all UIViewController stack as Array
        navigationArray.remove(at: navigationArray.count - 2) // To remove previous UIViewController
        viewControllers = navigationArray
    }
}
