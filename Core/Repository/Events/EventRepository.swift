//
//  EventsRepository.swift
//  Src
//
//  Created by BobaHasseb on 8/3/20.
//  Copyright © 2020 BobaHasseb. All rights reserved.
//

import Foundation

class EventRepository: Repository {
    let cacher: Cacher
    let networkClient: APIRouter
    public init(_ client: APIRouter = NetworkClient()) {
        networkClient = client
        cacher = Cacher(destination: .atFolder("Events"))
    }
    func getEventData(completion: @escaping RepositoryCompletion) {
        guard let url = Endpoint.getEventData().url else { return }
        let request = makeRequest(url: url, parameters: nil, header: nil, type: .get)
        getData(withRequest: request,
                name: String(describing: EventModel.self),
                decodingType: EventModel.self, strategy: .networkOnly, completion: completion)
    }
}
