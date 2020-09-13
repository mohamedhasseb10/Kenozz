//
//  CartModel.swift
//  Src
//
//  Created by BobaHasseb on 8/15/20.
//  Copyright © 2020 BobaHasseb. All rights reserved.
//

import Foundation

struct CartModel: Codable, Cachable {
    var fileName: String? = String(describing: CartModel.self)
    var success: Bool?
    var data: CartData? = CartData()
    var message: Int?
}

struct CartData: Codable {
    var count: Int?
    var subtotal: String?
    var items: [CartItem]? = [CartItem]()
}

struct CartItem: Codable {
    var id: Int?
    var qty: Int?
    var price: Int?
    var name: String?
    var rowId: String?
}

struct SendOrderModel {
    var id: String
    var qty: String
}
