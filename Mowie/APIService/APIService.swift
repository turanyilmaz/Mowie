//
//  APIService.swift
//  Mowie
//
//  Created by Turan Yilmaz on 8.04.2021.
//

import Foundation

enum APIError: Error {
    case serviceError
    case requestError(message: String)
    
    var message: String {
        switch self {
        case .serviceError:
            return "An error occured. Please try again later."
        case .requestError(let message):
            return message
        }
    }
}

class APIService {
    
    static let shared = APIService()
    
    private init() {}
    
    func callService<T: Codable>(request: RequestProtocol, completion: @escaping (Result<T, APIError>) -> Void) {
        
        ActivityIndicatorManager.shared.showIndicator()
        
        guard let url = request.url else {
            completion(.failure(.serviceError))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, urlResponse, error) in
            
            DispatchQueue.main.async {
                
                ActivityIndicatorManager.shared.hideIndicator()
                
                guard error == nil else {
                    completion(.failure(.requestError(message: error!.localizedDescription)))
                    return
                }
                
                guard let data = data else {
                    completion(.failure(.serviceError))
                    return
                }
                
                do {
                    let response = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(response))
                } catch {
                    completion(.failure(.serviceError))
                }
            }
        }.resume()
    }
}

protocol RequestProtocol {
    var url: URL? { get set }
}
