//
//  ChampionsRepository.swift
//  Src
//
//  Created by BobaHasseb on 9/9/20.
//  Copyright © 2020 BobaHasseb. All rights reserved.
//

import Foundation

class ChampionsRepository: Repository {
    let cacher: Cacher
    let networkClient: APIRouter
    public init(_ client: APIRouter = NetworkClient()) {
        networkClient = client
        cacher = Cacher(destination: .atFolder("Champions"))
    }
    func getChampionsData(completion: @escaping RepositoryCompletion) {
        guard let url = Endpoint.getChampionListData().url else { return }
        let request = makeRequest(url: url, parameters: nil, header: nil, type: .get)
        getData(withRequest: request,
                name: String(describing: ChampionsModel.self),
                decodingType: ChampionsModel.self, strategy: .networkOnly, completion: completion)
    }
}
