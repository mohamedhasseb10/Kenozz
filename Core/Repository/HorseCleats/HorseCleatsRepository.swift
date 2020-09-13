//
//  HorseCleatsRepository.swift
//  Src
//
//  Created by BobaHasseb on 8/5/20.
//  Copyright © 2020 BobaHasseb. All rights reserved.
//

import Foundation

class HorseCleatsRepository: Repository {
    let cacher: Cacher
    let networkClient: APIRouter
    public init(_ client: APIRouter = NetworkClient()) {
        networkClient = client
        cacher = Cacher(destination: .atFolder("HorseCleats"))
    }
    func getHorseCleatsData(completion: @escaping RepositoryCompletion) {
        guard let url = Endpoint.getHorseCleatsList().url else { return }
        let request = makeRequest(url: url, parameters: nil, header: nil, type: .get)
        getData(withRequest: request,
                name: String(describing: HorseCleatsModel.self),
                decodingType: HorseCleatsModel.self, strategy: .networkOnly, completion: completion)
    }
}
