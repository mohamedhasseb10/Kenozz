//
//  EditAccountRepository.swift
//  Src
//
//  Created by BobaHasseb on 8/8/20.
//  Copyright © 2020 BobaHasseb. All rights reserved.
//

import Foundation

class EditAccountRepository: Repository {
    let cacher: Cacher
    let networkClient: APIRouter
    public init(_ client: APIRouter = NetworkClient()) {
        networkClient = client
        cacher = Cacher(destination: .atFolder("EditAccount"))
    }
    func editAccount(with profileImage: String, and email: String,
                     and name: String,
                     and userId: String,
                     completion: @escaping RepositoryCompletion) {
        guard let url = Endpoint.editAccount().url else { return }
        let paramters = ["name": name, "email": email]
        let headers = ["user-id": userId]
        uploadData(withUrl: url, paramters: paramters, andHeader: headers,
                   andName: String(describing: EditAccountModel.self),
                   decodingType: EditAccountModel.self,
                   strategy: .networkOnly,
                   completion: completion)
    }
}
