//
//  UIImageView+Extension.swift
//  PinchGallery
//
//  Created by Turan Yilmaz on 12.03.2021.
//

import UIKit

extension UIImageView {
    
    func loadImage(url: URL?, completion: ((UIImage?) -> Void)? = nil) {
        guard let url = url else {
            return
        }

        URLSession.shared.dataTask(with: url) { (data, urlResponse, error) in
            
            guard let data = data else {
                return
            }

            let image = UIImage(data: data)
            
            DispatchQueue.main.async { [weak self] in
                self?.image = image
            }
            
            completion?(image)
            
        }.resume()
    }
}
