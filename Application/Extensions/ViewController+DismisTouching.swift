//
//  ViewController+DismisTouching.swift
//  MagixConcierge
//
//  Created by BobaHasseb on 3/9/20.
//  Copyright © 2020 BobaHasseb. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tapGesture = UITapGestureRecognizer(target: self,
                         action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }

    @objc func hideKeyboard() {
        view.endEditing(true)
    }
}
