//
//  TheFamousModel.swift
//  Src
//
//  Created by BobaHasseb on 8/10/20.
//  Copyright © 2020 BobaHasseb. All rights reserved.
//

import Foundation

struct TheFamousModel: Codable, Cachable {
    var fileName: String? = String(describing: TheFamousModel.self)
    var success: Bool?
    var data: TheFamousData? = TheFamousData()
    var message: Int?
}

struct TheFamousData: Codable {
    var following: String?
    var followers: String?
    var items: [TheFamousProductItem]? = [TheFamousProductItem]()
}

struct TheFamousProductItem: Codable {
    let id, name, price: String?
    let image: String?
}
