//
//  VideoRepository.swift
//  Src
//
//  Created by BobaHasseb on 8/3/20.
//  Copyright © 2020 BobaHasseb. All rights reserved.
//

import Foundation

class VideoRepository: Repository {
    let cacher: Cacher
    let networkClient: APIRouter
    public init(_ client: APIRouter = NetworkClient()) {
        networkClient = client
        cacher = Cacher(destination: .atFolder("Video"))
    }
    func getVideoData(completion: @escaping RepositoryCompletion) {
        guard let url = Endpoint.getVideo().url else { return }
        let request = makeRequest(url: url, parameters: nil, header: nil, type: .get)
        getData(withRequest: request,
                name: String(describing: VideoModel.self),
                decodingType: VideoModel.self, strategy: .networkOnly, completion: completion)
    }
}
