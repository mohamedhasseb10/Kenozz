//
//  TabBarItem.swift
//  We
//
//  Created by BobaHasseb on 11/11/19.
//  Copyright © 2019 BobaHasseb. All rights reserved.
//

import Foundation

import UIKit

enum RoundedTabBarItem {
    case myAcountItem, favouriteItem, sellersItem, cartItem, kenozMagazineItem, news,
    video, kenozTrolly, horseCleats
    var isRoundedItem: Bool {
        if case self = RoundedTabBarItem.sellersItem {
            return true
        }
        return false
    }
}

extension RoundedTabBarItem {

    var title: String {
        switch self {
        case .myAcountItem:
            return "حسابي"
        case .favouriteItem:
            return "المفضلة"
        case .sellersItem:
            return "البائعين"
        case .cartItem:
            return "عربة التسوق"
        case .kenozMagazineItem:
            return "مجلة كنوز"
        case .news:
            return "الاخبار"
        case .video:
            return "الفيديو"
        case .kenozTrolly:
            return "كنوز تروللي"
        case .horseCleats:
            return "مرابط"
        }
    }

    var tag: Int {
        switch self {
        case .myAcountItem:
            return 1
        case .favouriteItem:
            return 2
        case .sellersItem:
            return 3
        case .cartItem:
            return 4
        case .kenozMagazineItem:
            return 5
        case .news:
            return 6
        case .video:
            return 7
        case .kenozTrolly:
            return 8
        case .horseCleats:
            return 9
        }
    }

    var image: UIImage? {
        switch self {
        case .myAcountItem:
            return R.image.my_account()
        case .favouriteItem:
            return R.image.favourite()
        case .sellersItem:
            return R.image.sellers()
        case .cartItem:
            return R.image.cart()
        case .kenozMagazineItem:
            return R.image.news()
        case .news:
            return R.image.news()
        case .video:
            return R.image.video()
        case .kenozTrolly:
            return R.image.cart()
        case .horseCleats:
            return R.image.horsem()
        }
    }
    var tabBarItem: UITabBarItem {
        let tabItem = UITabBarItem(title: title, image: image, tag: tag)
        return tabItem
    }
}
