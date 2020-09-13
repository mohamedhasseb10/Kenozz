//
//  CleatsDetailsRepository.swift
//  Src
//
//  Created by BobaHasseb on 8/11/20.
//  Copyright © 2020 BobaHasseb. All rights reserved.
//

import Foundation

class CleatsDetailsRepository: Repository {
    let cacher: Cacher
    let networkClient: APIRouter
    public init(_ client: APIRouter = NetworkClient()) {
        networkClient = client
        cacher = Cacher(destination: .atFolder("CleatsDetails"))
    }
    func getCleatsDetailsData(with idd: Int, and type: Int, completion:
        @escaping RepositoryCompletion) {
        guard let url = Endpoint.getCleatsDetailsData(idd: idd, type:
            type).url else { return }
        let request = makeRequest(url: url, parameters: nil, header: nil, type: .get)
        getData(withRequest: request,
                name: String(describing: CleatsDetailsModel.self),
                decodingType: CleatsDetailsModel.self, strategy: .networkOnly, completion: completion)
    }
}
