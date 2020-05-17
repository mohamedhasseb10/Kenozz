//
//  NETWORK+ENDPOINTS.swift
//  Src
//
//  Created by xWARE on 5/4/20.
//  Copyright © 2020 xWARE. All rights reserved.
//

import Foundation

extension Endpoint {
    static func applicationSettings() -> Endpoint {
        let path = "/api/v2/organization/\(Environment.organizationID)/application/"
            + "\(Environment.appID)"
        return Endpoint(base: Environment.baseURL,
                        path: path)
    }
}
