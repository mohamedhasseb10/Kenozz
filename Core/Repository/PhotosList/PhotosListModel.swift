//
//  PhotoGraphersListModel.swift
//  Src
//
//  Created by BobaHasseb on 9/6/20.
//  Copyright © 2020 BobaHasseb. All rights reserved.
//

import Foundation

struct PhotoListModel: Codable, Cachable {
    var fileName: String? = String(describing: PhotoListModel.self)
    var success: Bool?
    var data: [PhotoListData]? = [PhotoListData]()
    var message: Int?
}

struct PhotoListData: Codable {
    var id: Int?
    var title, logo: String?
}
