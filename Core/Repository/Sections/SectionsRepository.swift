//
//  GeneralSectionsRepository.swift
//  Src
//
//  Created by BobaHasseb on 9/6/20.
//  Copyright © 2020 BobaHasseb. All rights reserved.
//

import Foundation

class SectionsRepository: Repository {
    let cacher: Cacher
    let networkClient: APIRouter
    public init(_ client: APIRouter = NetworkClient()) {
        networkClient = client
        cacher = Cacher(destination: .atFolder("Sections"))
    }
    func getSectionsData(idd: Int, completion: @escaping RepositoryCompletion) {
        guard let url = Endpoint.getSubMainCategory(idd: idd).url
            else { return }
        let request = makeRequest(url: url,
                                  parameters: nil, header: nil, type: .get)
        getData(withRequest: request,
                name: String(describing: SectionsModel.self),
                decodingType: SectionsModel.self,
                strategy: .networkOnly, completion: completion)
    }
}
