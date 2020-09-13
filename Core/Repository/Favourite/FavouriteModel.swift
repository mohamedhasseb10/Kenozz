//
//  FavouriteModel.swift
//  Src
//
//  Created by BobaHasseb on 8/10/20.
//  Copyright © 2020 BobaHasseb. All rights reserved.
//

import Foundation

struct FavouriteModel: Codable, Cachable {
    var fileName: String? = String(describing: FavouriteModel.self)
    var success: Bool?
    var data: FavouriteData? = FavouriteData()
    var message: Int?
}

struct FavouriteData: Codable {
    var items: [FavouriteItem]? = [FavouriteItem]()
}

struct FavouriteItem: Codable {
    let id, name, image: String?
    let qty, price: Int?
}
