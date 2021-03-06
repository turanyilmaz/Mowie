//
//  GenresWorker.swift
//  Mowie
//
//  Created by Turan Yilmaz on 7.04.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

class GenresWorker {
    
    let genresService: GenresServiceProtocol
    
    init(genresService: GenresServiceProtocol) {
        self.genresService = genresService
    }
    
    func getGenres(request: Genres.GetGenres.Request, completion: @escaping (Result<Genres.GetGenres.Response, APIError>) -> Void) {
        genresService.getGenres(request: request) { (result) in
            completion(result)
        }
    }
}
