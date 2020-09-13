//
//  CartRepository.swift
//  Src
//
//  Created by BobaHasseb on 8/15/20.
//  Copyright © 2020 BobaHasseb. All rights reserved.
//

import Foundation

class CartRepository: Repository {
    let cacher: Cacher
    let networkClient: APIRouter
    var userDefaults = UserDefaults.standard
    public init(_ client: APIRouter = NetworkClient()) {
        networkClient = client
        cacher = Cacher(destination: .atFolder("Cart"))
    }
    func getCartData( completion: @escaping RepositoryCompletion) {
        guard let apiToken = userDefaults.apiToken else { return }
        guard let userId = userDefaults.userID else { return }
        let userIdd = String(userId)
        let headers = ["X-CSRF-TOKEN": apiToken]
        guard let url = Endpoint.getCart(userId: userIdd).url else { return }
        print(url)
        let request = makeRequest(url: url, parameters: nil, header:
            headers, type: .get)
        getData(withRequest: request,
                name: String(describing: CartModel.self),
                decodingType: CartModel.self, strategy: .networkOnly,
                completion: completion)
    }
    func updateCart(with productId: Int,
                    and newQuantity: Int,
                    and rowId: String,
                    completion: @escaping RepositoryCompletion) {
        guard let url = Endpoint.updateCart().url else { return }
        guard let apiToken = userDefaults.apiToken else { return }
        guard let userId = userDefaults.userID else { return }
        let userIdd = String(userId)
        let paramters: [String: Any] = ["rowId": rowId, "id":
            productId, "new_qty": newQuantity]
        let headers = ["X-CSRF-TOKEN": apiToken, "user-id": userIdd]
        let request = makeRequest(url: url, parameters: paramters, header:
            headers, type: .post)
        getData(withRequest: request,
                name: String(describing: UpdateCartModel.self),
                decodingType: UpdateCartModel.self, strategy: .networkOnly,
                completion: completion)
    }

}
