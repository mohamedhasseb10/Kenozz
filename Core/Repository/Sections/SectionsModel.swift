//
//  SectionsModel.swift
//  Src
//
//  Created by BobaHasseb on 9/6/20.
//  Copyright © 2020 BobaHasseb. All rights reserved.
//

import Foundation

struct SectionsModel: Codable, Cachable {
    var fileName: String? = String(describing: SectionsModel.self)
    var success: Bool?
    var data: [SectionsItem]? = [SectionsItem]()
    var message: Int?
}

struct SectionsItem: Codable {
    var id: Int?
    var icon, type: String?
}
