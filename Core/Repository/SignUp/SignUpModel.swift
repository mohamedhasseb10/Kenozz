//
//  SignUpModel.swift
//  Src
//
//  Created by BobaHasseb on 8/6/20.
//  Copyright © 2020 BobaHasseb. All rights reserved.
//

import Foundation

struct SignUpModel: Codable, Cachable {
    var fileName: String? = String(describing: LoginModel.self)
    var success: Bool?
    var data: SignUpResultData? = SignUpResultData()
    var message: Int?
}

struct SignUpResultData: Codable {
    var username, email, lname, name: String?
    var id: Int?
}
