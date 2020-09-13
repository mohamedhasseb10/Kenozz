//
//  GeneralSectionsModel.swift
//  Src
//
//  Created by BobaHasseb on 9/6/20.
//  Copyright © 2020 BobaHasseb. All rights reserved.
//

import Foundation

struct GeneralSectionsModel: Codable, Cachable {
    var fileName: String? = String(describing: GeneralSectionsModel.self)
    var success: Bool?
    var data: [GeneralSectionsData]? = [GeneralSectionsData]()
    var message: Int?
}

struct GeneralSectionsData: Codable {
    var id: Int?
    var type, icon, cat_type: String?
}
