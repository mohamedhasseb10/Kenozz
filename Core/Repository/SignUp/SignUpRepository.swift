//
//  SignUpViewModel.swift
//  Src
//
//  Created by BobaHasseb on 8/6/20.
//  Copyright © 2020 BobaHasseb. All rights reserved.
//

import Foundation

class SignUpRepository: Repository {
    let cacher: Cacher
    let networkClient: APIRouter
    public init(_ client: APIRouter = NetworkClient()) {
        networkClient = client
        cacher = Cacher(destination: .atFolder("SignUp"))
    }
    func signUp(with email: String, and name: String, and password: String,
                and profileImage: String, completion: @escaping RepositoryCompletion) {
        guard let url = Endpoint.signUp().url else { return }
        let paramters = ["name": name, "password": password,
                         "lname": name, "email": email]
        let request = makeRequest(url: url, parameters: paramters, header: nil, type: .post)
        getData(withRequest: request,
                name: String(describing: SignUpModel.self),
                decodingType: SignUpModel.self, strategy: .networkOnly,
                completion: completion)
    }
}
