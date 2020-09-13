//
//  CompanyProductsModel.swift
//  Src
//
//  Created by BobaHasseb on 9/12/20.
//  Copyright © 2020 BobaHasseb. All rights reserved.
//

import Foundation

struct CompanyProductsModel: Codable, Cachable {
    var fileName: String? = String(describing: CompanyProductsModel.self)
    var success: Bool?
    var data: CompanyProductsData? = CompanyProductsData()
    var message: Int?
}

struct CompanyProductsData: Codable {
    var data: [CompanyProductItem]? = [CompanyProductItem]()
}

struct CompanyProductItem: Codable {
    let id, price: Int?
    let image, path, name, description: String?
}
