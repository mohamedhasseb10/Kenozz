//
//  KenozTrollyProductModel.swift
//  Src
//
//  Created by BobaHasseb on 8/10/20.
//  Copyright © 2020 BobaHasseb. All rights reserved.
//

import Foundation

struct KenozTrollyProductModel: Codable, Cachable {
    var fileName: String? = String(describing: KenozTrollyProductModel.self)
    var success: Bool?
    var data: KenozTrollyProductData? = KenozTrollyProductData()
    var message: Int?
}

struct KenozTrollyProductData: Codable {
    var data: [ProductItem]? = [ProductItem]()
}

struct ProductItem: Codable {
    let id, price: Int?
    let image, name, description: String?
}
