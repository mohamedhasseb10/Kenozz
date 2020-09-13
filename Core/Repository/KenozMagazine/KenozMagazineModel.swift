//
//  KenozMagazineModel.swift
//  Src
//
//  Created by BobaHasseb on 8/10/20.
//  Copyright © 2020 BobaHasseb. All rights reserved.
//

import Foundation

struct KenozMagazineModel: Codable, Cachable {
    var fileName: String? = String(describing: KenozMagazineModel.self)
    var success: Bool?
    var data: [KenozMagazineData]? = [KenozMagazineData]()
    var message: Int?
}

struct KenozMagazineData: Codable {
    var id: Int?
    var path, image: String?
}
