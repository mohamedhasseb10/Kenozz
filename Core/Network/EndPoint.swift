//
//  EndPoint.swift
//  Src
//
//  Created by xWARE on 5/3/20.
//  Copyright © 2020 xWARE. All rights reserved.
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
