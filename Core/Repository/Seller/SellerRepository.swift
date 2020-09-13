//
//  SellerRepository.swift
//  Src
//
//  Created by BobaHasseb on 8/11/20.
//  Copyright © 2020 BobaHasseb. All rights reserved.
//

import Foundation

class SellerRepository: Repository {
    let cacher: Cacher
    let networkClient: APIRouter
    public init(_ client: APIRouter = NetworkClient()) {
        networkClient = client
        cacher = Cacher(destination: .atFolder("Seller"))
    }
    func getSellerProductData(idd: Int, completion: @escaping RepositoryCompletion) {
        guard let url = Endpoint.getProducts(idd: idd).url else { return }
        print(url)
        let request = makeRequest(url: url, parameters: nil, header: nil, type: .get)
        getData(withRequest: request,
                name: String(describing: CompanyProductsModel.self),
                decodingType: CompanyProductsModel.self,
                strategy: .networkOnly, completion: completion)
    }
    func getAboutSellerData(idd: Int,
                            completion: @escaping RepositoryCompletion) {
        guard let url = Endpoint.getAboutSellerData(idd: idd ).url
            else { return }
        let request = makeRequest(url: url, parameters: nil, header: nil,
                       type: .get)
        getData(withRequest: request,
                name: String(describing: AboutSellerModel.self),
                decodingType: AboutSellerModel.self, strategy: .networkOnly, completion: completion)
    }
}
