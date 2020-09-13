//
//  Reactive+Loading.swift
//  NearBy-Places
//
//  Created by BobaHasseb on 5/3/20.
//  Copyright © 2020 BobaHasseb. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

extension UIViewController: loadingViewable {}

extension Reactive where Base: UIViewController {
    /// Bindable sink for `startAnimating()`, `stopAnimating()` methods.
    public var isAnimating: Binder<Bool> {
        return Binder(self.base, binding: { (viewController, active) in
            if active {
                viewController.startAnimating()
            } else {
                viewController.stopAnimating()
            }
        })
    }
}
