//
//  LocalClient.swift
//  Src
//
//  Created by BobaHasseb on 5/3/20.
//  Copyright © 2020 BobaHasseb. All rights reserved.
//

import Foundation

open class LocalClient: APIRouter {
    var fileName: String

    public init(fileName: String) {
        self.fileName = fileName
    }

    func makeRequest<T>(withRequest: URLRequest,
                        decodingType: T.Type,
                        completion: @escaping JSONTaskCompletionHandler) where T: Cachable, T: Decodable, T: Encodable {
        if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
            do {
                  let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                var genericModel = try JSONDecoder().decode(decodingType, from: data)
                genericModel.fileName = String(describing: T.self)
                completion(.success(genericModel))
              } catch {
                completion(.failure(.jsonConversionFailure))
              }
        }
    }
    func getConfig() {}
}
