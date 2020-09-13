//
//  FavouriteRepository.swift
//  Src
//
//  Created by BobaHasseb on 8/10/20.
//  Copyright © 2020 BobaHasseb. All rights reserved.
//

import Foundation

class FavouriteRepository: Repository {
    let cacher: Cacher
    let networkClient: APIRouter
    var userDefaults = UserDefaults.standard
    public init(_ client: APIRouter = NetworkClient()) {
        networkClient = client
        cacher = Cacher(destination: .atFolder("Favourite"))
    }
    func getFavouriteData(completion: @escaping RepositoryCompletion) {
        guard let userId = userDefaults.userID else { return }
        guard let url = Endpoint.getFavourite(userId: userId).url else { return }
        let request = makeRequest(url: url, parameters: nil, header: nil, type: .get)
        getData(withRequest: request,
                name: String(describing: FavouriteModel.self),
                decodingType: FavouriteModel.self, strategy: .networkOnly, completion: completion)
    }
}
