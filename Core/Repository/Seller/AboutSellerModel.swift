//
//  AboutSellerModel.swift
//  Src
//
//  Created by BobaHasseb on 8/16/20.
//  Copyright © 2020 BobaHasseb. All rights reserved.
//

import Foundation

struct AboutSellerModel: Codable, Cachable {
    var fileName: String? = String(describing: AboutSellerModel.self)
    var success: Bool?
    var data: [AboutSellerData]? = [AboutSellerData]()
    var message: Int?
}

struct AboutSellerData: Codable {
    var address, phone_contact, email,
        about_us, site, longitude, latitude: String?
}
