//
//  ChampionsModel.swift
//  Src
//
//  Created by BobaHasseb on 9/9/20.
//  Copyright © 2020 BobaHasseb. All rights reserved.
//

import Foundation

struct ChampionsModel: Codable, Cachable {
    var fileName: String? = String(describing: ChampionsModel.self)
    var success: Bool?
    var data: ChampionsData? = ChampionsData()
    var message: Int?
}

struct ChampionsData: Codable {
    var data: [ChampionItem]? = [ChampionItem]()
}

struct ChampionItem: Codable {
    var id: Int?
    var description, date, image, path: String?
}

