//
//  MyOrdersDetailsRepository.swift
//  Src
//
//  Created by BobaHasseb on 8/20/20.
//  Copyright © 2020 BobaHasseb. All rights reserved.
//

import Foundation

class MyOrdersDetailsRepository: Repository {
    let cacher: Cacher
    let networkClient: APIRouter
    var userDefaults = UserDefaults.standard
    public init(_ client: APIRouter = NetworkClient()) {
        networkClient = client
        cacher = Cacher(destination: .atFolder("MyOrdersDetails"))
    }
    func getOrdersDetailsData(with idd: Int, completion:
        @escaping RepositoryCompletion) {
        guard let url = Endpoint.getOrderDetailsData(idd: idd).url else { return }
        guard let userId = userDefaults.userID else { return }
        let userIdd = String(userId)
        let headers = ["user-id": userIdd]
        let request = makeRequest(url: url, parameters: nil, header: headers, type: .get)
        getData(withRequest: request,
                name: String(describing: MyOrdersDetailsModel.self),
                decodingType: MyOrdersDetailsModel.self, strategy: .networkOnly, completion: completion)
    }
}
