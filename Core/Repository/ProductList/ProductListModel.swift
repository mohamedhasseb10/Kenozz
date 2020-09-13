//
//  ProductListModel.swift
//  Src
//
//  Created by BobaHasseb on 8/17/20.
//  Copyright © 2020 BobaHasseb. All rights reserved.
//

import Foundation

struct ProductListModel: Codable, Cachable {
    var fileName: String? = String(describing: ProductListModel.self)
    var success: Bool?
    var data: ProductListData? = ProductListData()
    var message: Int?
}

struct ProductListData: Codable {
    var data: [ProductListItem]? = [ProductListItem]()
}

struct ProductListItem: Codable {
    let id, price, category_id: Int?
    let image, name, description: String?
}
