//
//  APIClient.swift
//  Src
//
//  Created by xWARE on 5/3/20.
//  Copyright © 2020 xWARE. All rights reserved.
//

import Foundation
import Alamofire

protocol APIRouter {
    func makeRequest(withRequest: URLRequest, completion: @escaping JSONTaskCompletionHandler)
    func makeRequest<T: Cachable>(withRequest: URLRequest,
                                  decodingType: T.Type,
                                  completion: @escaping JSONTaskCompletionHandler)  where T: Codable
    // swiftlint:disable:next function_parameter_count
    func uploadRequest<T: Cachable>(toUrl: URL,
                                    with data: Data,
                                    with name: String,
                                    and image: UIImage?,
                                    decodingType: T.Type, completion: @escaping JSONTaskCompletionHandler)
        where T: Codable
}

extension APIRouter {
    typealias JSONTaskCompletionHandler = (RequestResult<Cachable, RequestError>) -> Void
    // swiftlint:disable:next function_parameter_count
    func uploadRequest<T: Cachable>(toUrl: URL,
                                    with data: Data,
                                    with name: String,
                                    and image: UIImage?,
                                    decodingType: T.Type, completion: @escaping JSONTaskCompletionHandler)
        where T: Codable {
        Alamofire.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(data, withName: name)
            if let image = image {
                if let data = image.jpegData(compressionQuality: 0.5) {
                    multipartFormData.append(data, withName: "image", fileName: "image.jpeg", mimeType: "image/*")
                }
            }
        },
                         to: toUrl,
                         method: .post,
                         headers: nil,
                         encodingCompletion: { encodingResult in
                            switch encodingResult {
                            case .success(request:let upload,
                                          streamingFromDisk: _,
                                          streamFileURL:_):
                                upload.responseJSON(completionHandler: { (response: DataResponse<Any>) in
                                    switch response.result {
                                    case .failure:
                                        completion(.failure(.invalidResponse))
                                    case .success:
                                        self.decodeJsonResponse(decodingType: decodingType,
                                                                jsonObject: response.data!,
                                                                completion: completion)
                                    }
                                })
                            case .failure:
                                completion(.failure(.unknownError))
                            }
        })
    }
    // swiftlint:disable:next cyclomatic_complexity
    func makeRequest(withRequest: URLRequest, completion: @escaping JSONTaskCompletionHandler) {
        Alamofire.request(withRequest)
            .responseJSON(completionHandler: { (response) in
                switch response.result {
                case let .failure(error):
                    print(error)
                    completion(.failure(.connectionError))
                case let .success(value):
                    print(value)
                    if response.data != nil {
                        print(response)
                        if let code = response.response?.statusCode {
                            let result = response.result
                            switch code {
                            case 200:
                                if result.isSuccess {
                                    completion(.success(nil))
                                } else {
                                    completion(.failure(.unknownError))
                                }
                            case 401:
                                completion(.failure(.authenticationError))
                            case 403:
                                completion(.failure(.authorizationError))
                            case 404:
                                completion(.failure(.notFound))
                            case 500:
                                completion(.failure(.serverError))
                            case 501, 503:
                                completion(.failure(.serverUnavailable))
                            default:
                                completion(.failure(.unknownError))
                            }
                        }
                    }
                }
            })
    }
    // swiftlint:disable:next cyclomatic_complexity
    func makeRequest<T: Cachable>(withRequest: URLRequest,
                                  decodingType: T.Type,
                                  completion: @escaping JSONTaskCompletionHandler)  where T: Codable {
        Alamofire.request(withRequest)
            .responseJSON(completionHandler: { (response) in
                switch response.result {
                case let .failure(error):
                    print(error)
                    completion(.failure(.connectionError))
                case let .success(value):
                    print(value)
                    if let data = response.data {
                        print(response)
                        if let code = response.response?.statusCode {
                            print(code)
                            switch code {
                            case 200:
                                self.decodeJsonResponse(
                                    decodingType: decodingType,
                                    jsonObject: data,
                                    completion: completion)
                            case 401:
                                completion(.failure(.authenticationError))
                            case 403:
                                completion(.failure(.authorizationError))
                            case 404:
                                completion(.failure(.notFound))
                            case 500:
                                completion(.failure(.serverError))
                            case 501, 503:
                                completion(.failure(.serverUnavailable))
                            default:
                                completion(.failure(.unknownError))
                            }
                        }
                    }
                }
            })
    }
    func decodeJsonResponse<T: Cachable>(decodingType: T.Type,
                                         jsonObject: Data,
                                         completion: @escaping JSONTaskCompletionHandler) where T: Codable {
            do {
                var genericModel = try JSONDecoder().decode(decodingType, from: jsonObject)
                genericModel.fileName = String(describing: T.self)
                completion(.success(genericModel))
            } catch {
                completion(.failure(.jsonConversionFailure))
            }
    }
}
func makeRequest(url: URL, parameters: [String: Any]?, header: String?, type: HTTPMethod) -> URLRequest {
    var urlRequest = URLRequest(url: url, timeoutInterval: 10)
    do {
        urlRequest.httpMethod = type.rawValue
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue(header, forHTTPHeaderField: "Authorization")
        if let parameters = parameters {
            urlRequest.httpBody   = try JSONSerialization.data(withJSONObject: parameters)
        }
        return urlRequest
    } catch let error {
        print("Error : \(error.localizedDescription)")
    }
    return urlRequest
}
