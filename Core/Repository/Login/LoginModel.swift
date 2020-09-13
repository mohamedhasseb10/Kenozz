//
//  LoginModel.swift
//  Src
//
//  Created by BobaHasseb on 8/5/20.
//  Copyright © 2020 BobaHasseb. All rights reserved.
//

import Foundation

struct LoginModel: Codable, Cachable {
    var fileName: String? = String(describing: LoginModel.self)
    var success: Bool?
    var data: LoginResultData? = LoginResultData()
    var message: Int?
}

struct LoginResultData: Codable {
    var id: Int?
    var username, name, lname, api_token, email: String?
    var avatar: String?
}
