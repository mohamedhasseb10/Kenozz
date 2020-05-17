//
//  Networkcheck.swift
//  CiscoKSA
//
//  Created by Mohamed on 5/4/20.
//  Copyright © 2020 Mohamed. All rights reserved.
//

import Foundation

struct Network {
    static var reachability: CheckConnection!
    enum Status: String {
        case unreachable, wifi, wwan
    }
    enum Error: Swift.Error {
        case failedToSetCallout
        case failedToSetDispatchQueue
        case failedToCreateWith(String)
        case failedToInitializeWith(sockaddr_in)
    }
}
