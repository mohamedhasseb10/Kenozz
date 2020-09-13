//
//  MyOrdersDetailsModel.swift
//  Src
//
//  Created by BobaHasseb on 8/20/20.
//  Copyright © 2020 BobaHasseb. All rights reserved.
//

import Foundation

struct MyOrdersDetailsModel: Codable, Cachable {
    var fileName: String? = String(describing: MyOrdersDetailsModel.self)
    var success: Bool?
    var data: MyOrdersDetailsData? = MyOrdersDetailsData()
    var message: Int?
}

struct MyOrdersDetailsData: Codable {
    var order: [MyOrdersDetailsInformation]? = [MyOrdersDetailsInformation]()
    var item_line: [MyOrdersDetailsItem]? = [MyOrdersDetailsItem]()
}

struct MyOrdersDetailsInformation: Codable {
    var id, total: Int?
    var subtotal, currency: String?
    var discount_order: [DiscountOrder]? = [DiscountOrder]()
    var order_status: OrderStatus? = OrderStatus()
}

struct DiscountOrder: Codable {
    var value: Int?
}

struct MyOrdersDetailsItem: Codable {
    var name: String?
    var qty, price: Int?
}
