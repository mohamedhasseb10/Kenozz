//
//  ProductDetailsRepository.swift
//  Src
//
//  Created by BobaHasseb on 8/15/20.
//  Copyright © 2020 BobaHasseb. All rights reserved.
//

import Foundation

class ProductDetailsRepository: Repository {
    let cacher: Cacher
    let networkClient: APIRouter
    var userDefaults = UserDefaults.standard
    public init(_ client: APIRouter = NetworkClient()) {
        networkClient = client
        cacher = Cacher(destination: .atFolder("ProductDetails"))
    }
    func addToCart(with productId: Int,
                   and quantity: String,
                   completion: @escaping RepositoryCompletion) {
        guard let url = Endpoint.addToCart().url else { return }
        guard let apiToken = userDefaults.apiToken else { return }
        guard let userId = userDefaults.userID else { return }
        let userIdd = String(userId)
        let paramters: [String: Any] = ["product_id": productId, "qty": quantity]
        let headers = ["X-CSRF-TOKEN": apiToken, "userId": userIdd]
        print(userIdd)
        print(apiToken)
        let request = makeRequest(url: url, parameters: paramters, header:
            headers, type: .post)
        getData(withRequest: request,
                name: String(describing: ProductDetailsModel.self),
                decodingType: ProductDetailsModel.self, strategy: .networkOnly,
                completion: completion)
    }
    func addToFavourite(productId: String, completion: @escaping RepositoryCompletion) {
        guard let url = Endpoint.addToFavourite().url else { return }
        guard let userId = userDefaults.userID else { return }
        let userIdd = String(userId)
        let paramters = ["product_id": productId]
        let headers = ["userId": userIdd]
        let request = makeRequest(url: url, parameters: paramters, header:
            headers, type: .post)
        getData(withRequest: request,
                name: String(describing: AddToFavouriteModel.self),
                decodingType: AddToFavouriteModel.self, strategy: .networkOnly,
                completion: completion)
    }
    func getProductReview(productId: Int, completion: @escaping RepositoryCompletion) {
        guard let url = Endpoint.getProductReview(productId: productId).url else { return }
        print(url)
        let request = makeRequest(url: url, parameters: nil, header:
            nil, type: .get)
        getData(withRequest: request,
                name: String(describing: ProductReviewModel.self),
                decodingType: ProductReviewModel.self, strategy: .networkOnly,
                completion: completion)
    }

}
