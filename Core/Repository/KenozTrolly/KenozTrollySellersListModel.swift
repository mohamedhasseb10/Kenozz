//
//  KenozTrollySellersListModel.swift
//  Src
//
//  Created by BobaHasseb on 8/16/20.
//  Copyright © 2020 BobaHasseb. All rights reserved.
//

import Foundation

struct KenozTrollySellersListModel: Codable, Cachable {
    var fileName: String? = String(describing:
        KenozTrollySellersListModel.self)
    var success: Bool?
    var data: [KenozTrollySellersListModelData]? =
        [KenozTrollySellersListModelData]()
    var message: Int?
}

struct KenozTrollySellersListModelData: Codable {
    var id: Int?
    var name, logo, path: String?
}
