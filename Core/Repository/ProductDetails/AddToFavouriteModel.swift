//
//  AddToFavouriteModel.swift
//  Src
//
//  Created by BobaHasseb on 8/17/20.
//  Copyright © 2020 BobaHasseb. All rights reserved.
//

import Foundation

struct AddToFavouriteModel: Codable, Cachable {
    var fileName: String? = String(describing: AddToFavouriteModel.self)
    var error: Int?
    var msg: String?
}
