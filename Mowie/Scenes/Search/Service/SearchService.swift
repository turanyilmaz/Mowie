//
//  SearchService.swift
//  Mowie
//
//  Created by Turan Yilmaz on 16.08.2021.
//

import Foundation

protocol SearchServiceProtocol {
    func getSearchResult<T: RequestProtocol, U: Codable>(request: T,
                                                         completion: @escaping (Result<U, APIError>) -> Void)
}

final class SearchService: SearchServiceProtocol {
    
    
    func getSearchResult<T: RequestProtocol, U: Codable>(request: T,
                         completion: @escaping (Result<U, APIError>) -> Void) {
        APIService.shared.callService(request: request) { (result: Result<U, APIError>) in
            completion(result)
        }
    }
}
