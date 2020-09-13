//
//  ProductReview.swift
//  Src
//
//  Created by BobaHasseb on 8/30/20.
//  Copyright © 2020 BobaHasseb. All rights reserved.
//

import Foundation

struct ProductReviewModel: Codable, Cachable {
    var fileName: String? = String(describing: ProductReviewModel.self)
    var success: Bool?
    var data: [ProductReviewData]? = [ProductReviewData]()
    var message: Int?
}

struct ProductReviewData: Codable {
    var rates: String?
}
