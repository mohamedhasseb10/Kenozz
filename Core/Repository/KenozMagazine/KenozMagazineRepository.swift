//
//  KenozMagazineRepository.swift
//  Src
//
//  Created by BobaHasseb on 8/10/20.
//  Copyright © 2020 BobaHasseb. All rights reserved.
//

import Foundation

class KenozMagazineRepository: Repository {
    let cacher: Cacher
    let networkClient: APIRouter
    public init(_ client: APIRouter = NetworkClient()) {
        networkClient = client
        cacher = Cacher(destination: .atFolder("KenozMagazine"))
    }
    func getMagazineSliderData(completion: @escaping RepositoryCompletion) {
        guard let url = Endpoint.getMagazineSlider().url else { return }
        let request = makeRequest(url: url, parameters: nil, header: nil, type: .get)
        getData(withRequest: request,
                name: String(describing: KenozMagazineModel.self),
                decodingType: KenozMagazineModel.self, strategy: .networkOnly, completion: completion)
    }
    func getNewsData(completion: @escaping RepositoryCompletion) {
        guard let url = Endpoint.getNewsList().url else { return }
        print(url)
        let request = makeRequest(url: url, parameters: nil, header: nil, type: .get)
        getData(withRequest: request,
                name: String(describing: NewsModel.self),
                decodingType: NewsModel.self, strategy: .networkOnly, completion: completion)
    }
    func getHorseCleatsData(completion: @escaping RepositoryCompletion) {
        guard let url = Endpoint.getHorseCleatsList().url else { return }
        let request = makeRequest(url: url, parameters: nil, header: nil, type: .get)
        getData(withRequest: request,
                name: String(describing: HorseCleatsModel.self),
                decodingType: HorseCleatsModel.self, strategy: .networkOnly, completion: completion)
    }
}
