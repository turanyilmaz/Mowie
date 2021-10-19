//
//  UICollectionViewCell+Extension.swift
//  Mowie
//
//  Created by Turan Yilmaz on 9.04.2021.
//

import UIKit

extension UICollectionViewCell {
    
    static var cellIdentifier: String {
        return String(describing: Self.self)
    }
}
