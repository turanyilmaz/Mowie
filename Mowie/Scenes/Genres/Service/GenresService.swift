//
//  GenresService.swift
//  Mowie
//
//  Created by Turan Yilmaz on 8.04.2021.
//

import Foundation

protocol GenresServiceProtocol {
    func getGenres(request: Genres.GetGenres.Request, completion: @escaping (Result<Genres.GetGenres.Response, APIError>) -> Void)
}

class GenresService: GenresServiceProtocol {
    
    func getGenres(request: Genres.GetGenres.Request, completion: @escaping (Result<Genres.GetGenres.Response, APIError>) -> Void) {
        APIService.shared.callService(request: request) { (result: Result<Genres.GetGenres.Response, APIError>) in
            completion(result)
        }
    }
}
