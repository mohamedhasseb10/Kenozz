//
//  KenozTrollyRepository.swift
//  Src
//
//  Created by BobaHasseb on 8/1/20.
//  Copyright © 2020 BobaHasseb. All rights reserved.
//

import Foundation

class KenozTrollyRepository: Repository {
    let cacher: Cacher
    var networkClient: APIRouter
    public init(_ client: APIRouter = NetworkClient()) {
        networkClient = client
        cacher = Cacher(destination: .atFolder("HorseCleats"))
    }
    func getSliderData(completion: @escaping RepositoryCompletion) {
        networkClient = NetworkClient()
        guard let url = Endpoint.getMagazineSlider().url else { return }
        let request = makeRequest(url: url, parameters: nil, header: nil, type: .get)
        getData(withRequest: request,
                name: String(describing: KenozTrollySliderModel.self),
                decodingType: KenozTrollySliderModel.self, strategy: .networkOnly, completion: completion)
    }
    func getSellerListData(idd: Int, completion: @escaping
        RepositoryCompletion) {
        networkClient = NetworkClient()
        guard let url =
            Endpoint.getSellerOrFamousList(idd: idd).url else { return }
        let request = makeRequest(url: url, parameters: nil, header: nil, type: .get)
        getData(withRequest: request,
                name: String(describing: KenozTrollySellersListModel.self),
                decodingType: KenozTrollySellersListModel.self, strategy:
                            .networkOnly,
                completion: completion)
    }
    func getSectionsData(idd: Int, completion: @escaping
        RepositoryCompletion) {
        networkClient = NetworkClient()
        guard let url =
            Endpoint.getMainCategory().url else { return }
        let request = makeRequest(url: url, parameters: nil, header: nil, type: .get)
        getData(withRequest: request,
                name: String(describing: GeneralSectionsModel.self),
                decodingType: GeneralSectionsModel.self, strategy:
                            .networkOnly,
                completion: completion)
    }
    func getPhotoGraphersData(completion: @escaping
        RepositoryCompletion) {
        networkClient = LocalClient(fileName: "kenoz_trolly_products")
        guard let url =
            Endpoint.getSellerOrFamousList(idd: 0).url else { return }
        let request = makeRequest(url: url, parameters: nil, header: nil, type: .get)
        getData(withRequest: request,
                name: String(describing: PhotoGrapherModel.self),
                decodingType: PhotoGrapherModel.self, strategy:
                            .networkOnly,
                completion: completion)
    }
    func getAllProductsData(completion: @escaping RepositoryCompletion) {
        networkClient = NetworkClient()
        guard let url = Endpoint.getAllProductData().url else { return }
        let request = makeRequest(url: url, parameters: nil, header: nil, type: .get)
        getData(withRequest: request,
                name: String(describing: KenozTrollyProductModel.self),
                decodingType: KenozTrollyProductModel.self, strategy: .networkOnly, completion: completion)
    }
}
