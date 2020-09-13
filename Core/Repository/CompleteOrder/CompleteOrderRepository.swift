//
//  CompleteOrderRepository.swift
//  Src
//
//  Created by BobaHasseb on 8/15/20.
//  Copyright © 2020 BobaHasseb. All rights reserved.
//

import Foundation
import Alamofire
class CompleteOrderRepository: Repository {
    let cacher: Cacher
    let networkClient: APIRouter
    var userDefaults = UserDefaults.standard
    public init(_ client: APIRouter = NetworkClient()) {
        networkClient = client
        cacher = Cacher(destination: .atFolder("CompleteOrder"))
    }
    func makeOrder(with items: [[String: Any]],
                   completion: @escaping RepositoryCompletion) {
        guard let url = Endpoint.makeOrder().url else { return }
        guard let apiToken = userDefaults.apiToken else { return }
        guard let userId = userDefaults.userID else { return }
        let userIdd = String(userId)
        guard let theJSONData = try? JSONSerialization.data(
            withJSONObject: items,
            options: []) else {
                return
        }
        let theJSONText = String(data: theJSONData,
                                   encoding: .ascii)
        let paramters: [String: Any] = ["address_id": "1",
                                        "items": theJSONText ?? "",
                                        "payment": "1",
                                        "address": "1", "coupon_id": "1"]
        let headers = ["X-CSRF-TOKEN": apiToken, "user-id": userIdd]
        let request = makeRequest(url: url, parameters: paramters, header:
            headers, type: .post)
        getData(withRequest: request,
                name: String(describing: CompleteOrderModel.self),
                decodingType: CompleteOrderModel.self, strategy: .networkOnly,
                completion: completion)
    }
}
