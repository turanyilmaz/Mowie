//
//  ItemDetailService.swift
//  Mowie
//
//  Created by Turan Yilmaz on 14.04.2021.
//

import Foundation

protocol ItemDetailServiceProtocol {
//    func getMovieDetail(request: ItemDetail.GetItemDetail.BaseItemRequest,
//                        completion: @escaping (Result<ItemDetail.Movie.Response, APIError>) -> Void)
//    func getTVDetail(request: ItemDetail.GetItemDetail.BaseItemRequest,
//                     completion: @escaping (Result<ItemDetail.TV.Response, APIError>) -> Void)
    
    
    func getItemDetail(request: ItemDetail.GetItemDetail.BaseItemRequest,
                       completion: @escaping (Result<ItemDetail.GetItemDetail.BaseItemResponse, APIError>) -> Void)
}

final class ItemDetailService: ItemDetailServiceProtocol {
    
//    func getMovieDetail(request: ItemDetail.GetItemDetail.BaseItemRequest,
//                        completion: @escaping (Result<ItemDetail.Movie.Response, APIError>) -> Void) {
//        APIService.shared.callService(request: request) { (result: Result<ItemDetail.Movie.Response, APIError>) in
//            completion(result)
//        }
//    }
//
//    func getTVDetail(request: ItemDetail.GetItemDetail.BaseItemRequest,
//                        completion: @escaping (Result<ItemDetail.TV.Response, APIError>) -> Void) {
//        APIService.shared.callService(request: request) { (result: Result<ItemDetail.TV.Response, APIError>) in
//            completion(result)
//        }
//    }
    
    func getItemDetail(request: ItemDetail.GetItemDetail.BaseItemRequest,
                        completion: @escaping (Result<ItemDetail.GetItemDetail.BaseItemResponse, APIError>) -> Void) {
        APIService.shared.callService(request: request) { (result: Result<ItemDetail.GetItemDetail.BaseItemResponse, APIError>) in
            completion(result)
        }
    }
   
}
