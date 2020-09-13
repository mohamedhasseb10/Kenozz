//
//  ProductDetailsModel.swift
//  Src
//
//  Created by BobaHasseb on 8/15/20.
//  Copyright © 2020 BobaHasseb. All rights reserved.
//

import Foundation

struct ProductDetailsModel: Codable, Cachable {
    var fileName: String? = String(describing: ProductDetailsModel.self)
    var error: Int?
    var count_cart: Int?
    var msg: String?
}

