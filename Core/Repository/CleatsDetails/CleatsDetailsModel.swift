//
//  CleatsDetailsModel.swift
//  Src
//
//  Created by BobaHasseb on 8/11/20.
//  Copyright © 2020 BobaHasseb. All rights reserved.
//

import Foundation

struct CleatsDetailsModel: Codable, Cachable {
    var fileName: String? = String(describing: CleatsDetailsModel.self)
    var success: Bool?
    var data: [CleatsDetailsData]? = [CleatsDetailsData]()
    var message: Int?
}

struct CleatsDetailsData: Codable {
    var id: Int?
    var image, path: String?
}
