//
//  NewsModel.swift
//  Src
//
//  Created by BobaHasseb on 8/4/20.
//  Copyright © 2020 BobaHasseb. All rights reserved.
//

import Foundation

struct NewsModel: Codable, Cachable {
    var fileName: String? = String(describing: NewsModel.self)
    var success: Bool?
    var data: NewsData? = NewsData()
    var message: Int?
}

struct NewsData: Codable {
    var data: [NewsItem]? = [NewsItem]()
}

struct NewsItem: Codable {
    var id: Int?
    var title, image, content, path: String?
}
