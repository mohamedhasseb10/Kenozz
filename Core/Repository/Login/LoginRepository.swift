//
//  LoginRepository.swift
//  Src
//
//  Created by BobaHasseb on 8/5/20.
//  Copyright © 2020 BobaHasseb. All rights reserved.
//

import Foundation

class LoginRepository: Repository {
    let cacher: Cacher
    let networkClient: APIRouter
    public init(_ client: APIRouter = NetworkClient()) {
        networkClient = client
        cacher = Cacher(destination: .atFolder("Login"))
    }
    func login(with email: String, and password: String, completion: @escaping RepositoryCompletion) {
        guard let url = Endpoint.login().url else { return }
        let paramters = ["email": email, "password": password]
        let request = makeRequest(url: url, parameters: paramters, header: nil, type: .post)
        getData(withRequest: request,
                name: String(describing: LoginModel.self),
                decodingType: LoginModel.self, strategy: .networkOnly,
                completion: completion)
    }
}
