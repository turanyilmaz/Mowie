//
//  CastDetailWorker.swift
//  Mowie
//
//  Created by Turan Yilmaz on 22.04.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

class CastDetailWorker {
    let castDetailService: CastDetailServiceProtocol
    
    init(castDetailService: CastDetailServiceProtocol) {
        self.castDetailService = castDetailService
    }
    
    func getCastDetail(request: CastDetail.GetCast.Request,
                       completion: @escaping (Result<CastDetail.GetCast.Response, APIError>) -> Void) {
        castDetailService.getCastDetail(request: request) { (result) in
            completion(result)
        }
    }
}