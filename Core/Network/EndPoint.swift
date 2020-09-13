//
//  EndPoint.swift
//  Src
//
//  Created by BobaHasseb on 5/3/20.
//  Copyright © 2020 BobaHasseb. All rights reserved.
//
import Foundation

struct Endpoint {
    let base: String
    let path: String
}
extension Endpoint {
    var url: URL? {
        return URL(string: base + path)
    }
}
