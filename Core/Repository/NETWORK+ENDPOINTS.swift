//
//  NETWORK+ENDPOINTS.swift
//  Src
//
//  Created by BobaHasseb on 5/4/20.
//  Copyright © 2020 BobaHasseb. All rights reserved.
//

import Foundation

extension Endpoint {
    static func applicationSettings() -> Endpoint {
        let path = "/api/v2/organization/test/application/test"
        let base = "https://us04web.zoom.us"
        return Endpoint(base: base,
                        path: path)
    }
    static func login() -> Endpoint {
        let path = "/auth/login"
        return Endpoint(base: Environment.hoursehighcoderURL,
                        path: path)
    }
    static func signUp() -> Endpoint {
        let path = "/auth/register"
        return Endpoint(base: Environment.hoursehighcoderURL,
                        path: path)
    }
    static func editAccount() -> Endpoint {
        let path = "/authapi/edit-user"
        return Endpoint(base: Environment.hoursehighcoderURL,
                        path: path)
    }
    static func getVideo() -> Endpoint {
        let path = "/api/get-video"
        return Endpoint(base: Environment.hoursehighcoderURL,
                        path: path)
    }
    static func getNewsList() -> Endpoint {
        let path = "/api/get-magazine-topic/1"
        return Endpoint(base: Environment.hoursehighcoderURL,
                        path: path)
    }
    static func getHorseCleatsList() -> Endpoint {
        let path = "/api/factoriesList/11"
        return Endpoint(base: Environment.hoursehighcoderURL,
                        path: path)
    }
    static func getMagazineSlider() -> Endpoint {
        let path = "/api/get-banner-magazine/1?type=1"
        return Endpoint(base: Environment.hoursehighcoderURL,
                        path: path)
    }
    static func getEventData() -> Endpoint {
        let path = "/api/get-events"
        return Endpoint(base: Environment.hoursehighcoderURL,
                        path: path)
    }
    static func getCleatsDetailsData(idd: Int, type: Int) -> Endpoint {
        let path = "/api/slider/banners/\(idd)?type=\(type)"
        return Endpoint(base: Environment.hoursehighcoderURL,
                        path: path)
     }
    static func getSellerOrFamousList(idd: Int) -> Endpoint {
        let path = "/api/factoriesList/\(idd)"
        return Endpoint(base: Environment.hoursehighcoderURL,
                        path: path)
     }
    static func getAllProductData() -> Endpoint {
        let path = "/api/product/search/all"
        return Endpoint(base: Environment.hoursehighcoderURL,
                        path: path)
    }
    static func getSellerProductData(idd: Int) -> Endpoint {
        let path = "/api/get-most-product?company=\(idd)"
        return Endpoint(base: Environment.hoursehighcoderURL,
                        path: path)
    }
    static func getSectionsData(idd: Int) -> Endpoint {
        let path = "/api/vendor/categories/\(idd)"
        return Endpoint(base: Environment.hoursehighcoderURL,
                        path: path)
    }
    static func getAboutSellerData(idd: Int) -> Endpoint {
        let path = "/api/factoriesProfile/\(idd)/"
        return Endpoint(base: Environment.hoursehighcoderURL,
                        path: path)
    }
    static func getProducts(idd: Int) ->
        Endpoint {
        let path = "/api/factoriesProducts/\(idd)/?category_id=0"
        return Endpoint(base: Environment.hoursehighcoderURL,
                        path: path)
    }
    static func getProductDetails(idd: Int, categoryId: Int) ->
        Endpoint {
        let path = "/api/productDetail/1/50"
        return Endpoint(base: Environment.hoursehighcoderURL,
                        path: path)
    }
    static func getProductReview(productId: Int) ->
        Endpoint {
        let path = "/api/productReview/1/\(productId)"
        return Endpoint(base: Environment.hoursehighcoderURL,
                        path: path)
    }
    static func addToCart() -> Endpoint {
        let path = "/cartapi/addToCart"
        return Endpoint(base: Environment.hoursehighcoderURL,
                        path: path)
    }
    static func getCart(userId: String) -> Endpoint {
        let path = "/cartapi/cart/\(userId)"
        return Endpoint(base: Environment.hoursehighcoderURL,
                        path: path)
     }
    static func updateCart() -> Endpoint {
        let path = "/cartapi/updateCart"
        return Endpoint(base: Environment.hoursehighcoderURL,
                        path: path)
    }
    static func getFavourite(userId: Int) -> Endpoint {
        let path = "/cartapi/Fav/\(userId)"
        return Endpoint(base: Environment.hoursehighcoderURL,
                        path: path)
     }
    static func addToFavourite() -> Endpoint {
        let path = "/cartapi/addToFav"
        return Endpoint(base: Environment.hoursehighcoderURL,
                        path: path)
     }
    static func makeOrder() -> Endpoint {
        let path = "/authapi/storeOrderWithItems"
        return Endpoint(base: Environment.hoursehighcoderURL,
                        path: path)
    }
    static func getOrdersListData() -> Endpoint {
        let path = "/authapi/userorders?status=0"
        return Endpoint(base: Environment.hoursehighcoderURL,
                        path: path)
    }
    static func getOrderDetailsData(idd: Int) -> Endpoint {
        let path = "/authapi/orderDetail/\(idd)"
        return Endpoint(base: Environment.hoursehighcoderURL,
                        path: path)
    }
    static func getConfigData() -> Endpoint {
        let path = "/api/configs"
        return Endpoint(base: Environment.hoursehighcoderURL,
                        path: path)
    }
    static func getMainCategory() -> Endpoint {
        let path = "/api/factoriesCategory"
        return Endpoint(base: Environment.hoursehighcoderURL,
                        path: path)
    }
    static func getSubMainCategory(idd: Int) -> Endpoint {
        let path = "/api/factorySubCategory/\(idd)"
        return Endpoint(base: Environment.hoursehighcoderURL,
                        path: path)
    }
    static func getChampionListData() -> Endpoint {
        let path = "/api/champion"
        return Endpoint(base: Environment.hoursehighcoderURL,
                        path: path)
    }
}
