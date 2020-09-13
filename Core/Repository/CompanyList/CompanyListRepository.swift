//
//  CompanyListRepository.swift
//  Src
//
//  Created by BobaHasseb on 9/13/20.
//  Copyright © 2020 BobaHasseb. All rights reserved.
//

import Foundation

class CompanyListRepository: Repository {
    let cacher: Cacher
    let networkClient: APIRouter
    public init(_ client: APIRouter = NetworkClient()) {
        networkClient = client
        cacher = Cacher(destination: .atFolder("CompanyList"))
    }
    func getCompanyListData(idd: Int, completion: @escaping
        RepositoryCompletion) {
        guard let url =
            Endpoint.getSellerOrFamousList(idd: idd).url else { return }
        let request = makeRequest(url: url, parameters: nil, header: nil, type: .get)
        getData(withRequest: request,
                name: String(describing: CompanyListModel.self),
                decodingType: CompanyListModel.self, strategy:
                            .networkOnly,
                completion: completion)
    }

}
