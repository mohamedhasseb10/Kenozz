//
//  TermsAndPolicesRepository.swift
//  Src
//
//  Created by BobaHasseb on 8/29/20.
//  Copyright © 2020 BobaHasseb. All rights reserved.
//

import Foundation

class TermsAndpolicesRepository: Repository {
    let cacher: Cacher
    let networkClient: APIRouter
    public init(_ client: APIRouter = NetworkClient()) {
        networkClient = client
        cacher = Cacher(destination: .atFolder("TermsAndpolices"))
    }
    func getConfigData(completion:
        @escaping RepositoryCompletion) {
        guard let url = Endpoint.getConfigData().url else { return }
        let request = makeRequest(url: url, parameters: nil, header: nil, type: .get)
        getData(withRequest: request,
                name: String(describing: ConfigModel.self),
                decodingType: ConfigModel.self, strategy: .networkOnly, completion: completion)
    }
}
