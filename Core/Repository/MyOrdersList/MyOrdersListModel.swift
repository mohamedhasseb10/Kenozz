//
//  MyOrdersListModel.swift
//  Src
//
//  Created by BobaHasseb on 8/19/20.
//  Copyright © 2020 BobaHasseb. All rights reserved.
//

import Foundation

struct MyOrdersListModel: Codable, Cachable {
    var fileName: String? = String(describing: MyOrdersListModel.self)
    var success: Bool?
    var data: MyOrdersListData? = MyOrdersListData()
    var message: Int?
}

struct MyOrdersListData: Codable {
    var data: [MyOrdersListItem]? = [MyOrdersListItem]()
}

struct MyOrdersListItem: Codable {
    var id, total: Int?
    var subtotal, currency: String?
    var order_status: OrderStatus? = OrderStatus()
}
struct OrderStatus: Codable {
    var id: Int?
    var name: String?
}
