//
//  NewsRepository.swift
//  Src
//
//  Created by BobaHasseb on 8/4/20.
//  Copyright © 2020 BobaHasseb. All rights reserved.
//

import Foundation

class NewsRepository: Repository {
    let cacher: Cacher
    let networkClient: APIRouter
    public init(_ client: APIRouter = NetworkClient()) {
        networkClient = client
        cacher = Cacher(destination: .atFolder("News"))
    }
    func getNewsData(completion: @escaping RepositoryCompletion) {
        guard let url = Endpoint.getNewsList().url else { return }
        print(url)
        let request = makeRequest(url: url, parameters: nil, header: nil, type: .get)
        getData(withRequest: request,
                name: String(describing: NewsModel.self),
                decodingType: NewsModel.self, strategy: .networkOnly, completion: completion)
    }
}
