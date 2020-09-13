//
//  TableViewExtenion.swift
//  MagixConcierge
//
//  Created by BobaHasseb on 3/3/20.
//  Copyright © 2020 BobaHasseb. All rights reserved.
//

import UIKit
extension UITableView {
    func registerNib(identifier: String) {
         let tableNib = UINib(nibName: identifier, bundle: nil)
         self.register(tableNib, forCellReuseIdentifier: identifier )
     }
}
extension UICollectionView {
    func registerNib(identifier: String) {
        let collectionNib = UINib(nibName: identifier, bundle: nil)
        self.register(collectionNib, forCellWithReuseIdentifier: identifier )
    }
}
