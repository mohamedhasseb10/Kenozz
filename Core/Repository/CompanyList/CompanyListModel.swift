//
//  CompanyListModel.swift
//  Src
//
//  Created by BobaHasseb on 9/13/20.
//  Copyright © 2020 BobaHasseb. All rights reserved.
//

import Foundation

struct CompanyListModel: Codable, Cachable {
    var fileName: String? = String(describing: CompanyListModel.self)
    var success: Bool?
    var data: [CompanyListData]? = [CompanyListData]()
    var message: Int?
}

struct CompanyListData: Codable {
    var id: Int?
    var name, logo, path: String?
}
