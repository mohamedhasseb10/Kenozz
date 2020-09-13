//
//  CompleteOrderModel.swift
//  Src
//
//  Created by BobaHasseb on 8/15/20.
//  Copyright © 2020 BobaHasseb. All rights reserved.
//

import Foundation

struct CompleteOrderModel: Codable, Cachable {
    var fileName: String? = String(describing: CompleteOrderModel.self)
    var success: Bool?
    var data: [CompleteOrderData]? = [CompleteOrderData]()
    var message: Int?
}

struct CompleteOrderData: Codable {
    var order_id: Int?
}
