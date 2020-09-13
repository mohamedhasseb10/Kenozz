//
//  VideoModel.swift
//  Src
//
//  Created by BobaHasseb on 8/3/20.
//  Copyright © 2020 BobaHasseb. All rights reserved.
//

import Foundation

struct VideoModel: Codable, Cachable {
    var fileName: String? = String(describing: VideoModel.self)
    var success: Bool?
    var data: VideoData? = VideoData()
    var message: Int?
}

struct VideoData: Codable {
    var data: [VideoItem]? = [VideoItem]()
}

struct VideoItem: Codable {
    var url: String?
    var image: String?
    var path: String?
}
