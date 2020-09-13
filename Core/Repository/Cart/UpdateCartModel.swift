//
//  UpdateCartModel.swift
//  Src
//
//  Created by BobaHasseb on 8/22/20.
//  Copyright © 2020 BobaHasseb. All rights reserved.
//

import Foundation

struct UpdateCartModel: Codable, Cachable {
    var fileName: String? = String(describing: UpdateCartModel.self)
    var success: Bool?
    var message: String?
}
