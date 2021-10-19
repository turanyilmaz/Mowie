//
//  ItemsService.swift
//  Mowie
//
//  Created by Turan Yilmaz on 8.04.2021.
//

import Foundation

protocol ItemsServiceProtocol {
    func getMovieItems(request: Items.Movie.Request, completion: @escaping (Result<Items.Movie.Response, APIError>) -> Void)
    func getTVItems(request: Items.TV.Request, completion: @escaping (Result<Items.TV.Response, APIError>) -> Void)
}

class ItemsService: ItemsServiceProtocol {
    
    func getMovieItems(request: Items.Movie.Request, completion: @escaping (Result<Items.Movie.Response, APIError>) -> Void) {
        APIService.shared.callService(request: request) { (result: Result<Items.Movie.Response, APIError>) in
            completion(result)
        }
    }
    
    func getTVItems(request: Items.TV.Request, completion: @escaping (Result<Items.TV.Response, APIError>) -> Void) {
        APIService.shared.callService(request: request) { (result: Result<Items.TV.Response, APIError>) in
            completion(result)
        }
    }
}
