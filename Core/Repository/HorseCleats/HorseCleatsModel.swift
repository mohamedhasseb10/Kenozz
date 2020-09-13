//
//  HorseCleatsModel.swift
//  Src
//
//  Created by BobaHasseb on 8/5/20.
//  Copyright © 2020 BobaHasseb. All rights reserved.
//

import Foundation

struct HorseCleatsModel: Codable, Cachable {
    var fileName: String? = String(describing: HorseCleatsModel.self)
    var success: Bool?
    var data: [HorseCleatsData]? = [HorseCleatsData]()
    var message: Int?
}

struct HorseCleatsData: Codable {
    var id: Int?
    var name, logo, path: String?
}
