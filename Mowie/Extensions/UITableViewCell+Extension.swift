//
//  UITableViewCell+Extension.swift
//  Mowie
//
//  Created by Turan Yilmaz on 7.04.2021.
//

import UIKit

extension UITableViewCell {
    
    static var cellIdentifier: String {
        return String(describing: Self.self)
    }
}
