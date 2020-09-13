//
//  EditAccountModel.swift
//  Src
//
//  Created by BobaHasseb on 8/8/20.
//  Copyright © 2020 BobaHasseb. All rights reserved.
//
import Foundation

struct EditAccountModel: Codable, Cachable {
    var fileName: String? = String(describing: EditAccountModel.self)
    var success: Bool?
    var data: EditAccountResultData? = EditAccountResultData()
    var message: Int?
}

struct EditAccountResultData: Codable {
    var id: Int?
    var username, name, lname, email: String?
    var avatar: String?
}
