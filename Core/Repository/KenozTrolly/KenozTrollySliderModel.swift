//
//  KenozTrollyModel.swift
//  Src
//
//  Created by BobaHasseb on 8/1/20.
//  Copyright © 2020 BobaHasseb. All rights reserved.
//

import Foundation

struct KenozTrollySliderModel: Codable, Cachable {
    var fileName: String? = String(describing: KenozTrollySliderModel.self)
    var success: Bool?
    var data: [KenozTrollySliderData]? = [KenozTrollySliderData]()
    var message: Int?
}

struct KenozTrollySliderData: Codable {
    var id: Int?
    var path, image: String?
}
