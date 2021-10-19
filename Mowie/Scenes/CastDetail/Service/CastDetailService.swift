//
//  CastDetailService.swift
//  Mowie
//
//  Created by Turan Yilmaz on 23.04.2021.
//

import Foundation

protocol CastDetailServiceProtocol {
    func getCastDetail(request: CastDetail.GetCast.Request,
                       completion: @escaping (Result<CastDetail.GetCast.Response, APIError>) -> Void)
}

final class CastDetailService: CastDetailServiceProtocol {
    
    func getCastDetail(request: CastDetail.GetCast.Request,
                   completion: @escaping (Result<CastDetail.GetCast.Response, APIError>) -> Void) {
        APIService.shared.callService(request: request) { (result: Result<CastDetail.GetCast.Response, APIError>) in
            completion(result)
        }
    }
}
