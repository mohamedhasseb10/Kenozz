//
//  Repository.swift
//  Src
//
//  Created by BobaHasseb on 5/3/20.
//  Copyright © 2020 BobaHasseb. All rights reserved.
//

import Foundation

protocol Repository {
    var networkClient: APIRouter { get }
    var cacher: Cacher { get }

    func getData<T: Cachable>(withRequest: URLRequest,
                              name: String,
                              decodingType: T.Type,
                              strategy: Strategy,
                              completion: @escaping RepositoryCompletion)
        where T: Codable
}

extension Repository {
    typealias RepositoryCompletion = (RequestResult<Cachable, RequestError>) -> Void
    func getData<T: Cachable>(withRequest: URLRequest,
                              name: String,
                              decodingType: T.Type,
                              strategy: Strategy,
                              completion: @escaping RepositoryCompletion)
        where T: Codable {
            networkClient.makeRequest(withRequest: withRequest, decodingType: decodingType) { (result) in
                switch result {
                case .success(let data):
                    if strategy == .defaultStrategy {
                        self.cacher.persist(item: data!) { (_, _) in
                    }
                  }
                case .failure(.connectionError):
                    if strategy == .defaultStrategy {
                        let cached: T? = self.cacher.load(fileName: name)
                        completion(.success(cached))
                        return
                    }
                default :
                    break
                }
                completion(result)
            }
    }
    // swiftlint:disable:next function_parameter_count
    func uploadData<T: Cachable>(withUrl: URL,
                                 paramters: [String: String],
                                 andHeader: [String: String],
                                 andName: String,
                                 decodingType: T.Type,
                                 strategy: Strategy,
                                 completion: @escaping RepositoryCompletion)
        where T: Codable {
            networkClient
                .uploadRequest(toUrl: withUrl,
                               with: paramters,
                               and: andHeader,
                               and: andName,
                               decodingType: decodingType) { (result) in
                                switch result {
                                case .success(let data):
                                    if strategy == .defaultStrategy {
                                        self.cacher.persist(item: data!) { (_, _) in
                                        }
                                    }
                                case .failure(.connectionError):
                                    if strategy == .defaultStrategy {
                                        let cached: T? = self.cacher.load(fileName: andName)
                                        completion(.success(cached))
                                        return
                                    }
                                default :
                                    break
                                }
                                completion(result)
            }
    }
}
