//
//  TheFamousRepository.swift
//  Src
//
//  Created by BobaHasseb on 8/10/20.
//  Copyright © 2020 BobaHasseb. All rights reserved.
//

import Foundation

class TheFamousRepository: Repository {
    let cacher: Cacher
    let networkClient: APIRouter
    public init(_ client: APIRouter = NetworkClient()) {
        networkClient = client
        cacher = Cacher(destination: .atFolder("TheFamous"))
    }
    func getProductsData(idd: Int, completion: @escaping RepositoryCompletion) {
        guard let url = Endpoint.getProducts(idd: idd).url else { return }
        let request = makeRequest(url: url, parameters: nil, header: nil, type: .get)
        getData(withRequest: request,
                name: String(describing: ProductListModel.self),
                decodingType: ProductListModel.self, strategy: .networkOnly, completion: completion)
    }
}
