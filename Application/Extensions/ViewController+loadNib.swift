//
//  ViewController+loadNib.swift
//  Src
//
//  Created by BobaHasseb on 5/3/20.
//  Copyright © 2020 BobaHasseb. All rights reserved.
//

import UIKit

extension UIViewController {
    static func instantiateFromNib() -> Self? {
        func instantiateFromNib<T: UIViewController>(_ viewType: T.Type) -> T? {
            return Bundle.main.loadNibNamed(String(describing: T.self),
                                     owner: nil, options: nil)?.first as? T
        }
        return instantiateFromNib(self)
    }
}
