//
//  ForgetPasswordModel.swift
//  Src
//
//  Created by BobaHasseb on 8/6/20.
//  Copyright © 2020 BobaHasseb. All rights reserved.
//

import Foundation

struct ForgetPasswordModel: Codable, Cachable {
    var fileName: String? = String(describing: ForgetPasswordModel.self)
    var success: Bool?
    var message: Int?
}
