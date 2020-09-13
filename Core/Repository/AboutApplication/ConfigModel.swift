//
//  AboutApplication.swift
//  Src
//
//  Created by BobaHasseb on 8/29/20.
//  Copyright © 2020 BobaHasseb. All rights reserved.
//

import Foundation

struct ConfigModel: Codable, Cachable {
    var fileName: String? = String(describing: ConfigModel.self)
    var success: Bool?
    var data: [ConfigData]? = [ConfigData]()
    var message: Int?
}

struct ConfigData: Codable {
    var polices_and_condition: String?
    var about_app: String?
}
