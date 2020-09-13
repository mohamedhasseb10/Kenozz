//
//  MyOrdersListRepository.swift
//  Src
//
//  Created by BobaHasseb on 8/19/20.
//  Copyright © 2020 BobaHasseb. All rights reserved.
//

import Foundation

class MyOrdersListRepository: Repository {
    let cacher: Cacher
    let networkClient: APIRouter
    var userDefaults = UserDefaults.standard
    public init(_ client: APIRouter = NetworkClient()) {
        networkClient = client
        cacher = Cacher(destination: .atFolder("MyOrdersList"))
    }
    func getOrdersListData( completion: @escaping RepositoryCompletion) {
        guard let userId = userDefaults.userID else { return }
        let userIdd = String(userId)
        let headers = ["user-id": userIdd]
        guard let url = Endpoint.getOrdersListData().url else { return }
        print(url)
        let request = makeRequest(url: url, parameters: nil, header:
            headers, type: .get)
        getData(withRequest: request,
                name: String(describing: MyOrdersListModel.self),
                decodingType: MyOrdersListModel.self, strategy: .networkOnly,
                completion: completion)
    }
}
