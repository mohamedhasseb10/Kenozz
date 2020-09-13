//
//  PhotoGrapherModel.swift
//  Src
//
//  Created by BobaHasseb on 9/7/20.
//  Copyright © 2020 BobaHasseb. All rights reserved.
//

import Foundation

struct PhotoGrapherModel: Codable, Cachable {
    var fileName: String? = String(describing: PhotoGrapherModel.self)
    var success: Bool?
    var data: PhotoGrapherData? = PhotoGrapherData()
    var message: Int?
}

struct PhotoGrapherData: Codable {
    var data: [PhotoGrapherItem]? = [PhotoGrapherItem]()
}

struct PhotoGrapherItem: Codable {
    var id: Int?
    var image, name: String?
}
