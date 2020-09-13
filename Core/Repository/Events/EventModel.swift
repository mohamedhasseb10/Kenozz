//
//  EventsModel.swift
//  Src
//
//  Created by BobaHasseb on 8/3/20.
//  Copyright © 2020 BobaHasseb. All rights reserved.
//

import Foundation

struct EventModel: Codable, Cachable {
    var fileName: String? = String(describing: EventModel.self)
    var success: Bool?
    var data: [EventData]? = [EventData]()
    var message: Int?
}

struct EventData: Codable {
    var id: Int?
    var name, description, event_date, image, short_description, path: String?
}
