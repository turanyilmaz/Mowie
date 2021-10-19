//
//  Instatiable+Extension.swift
//  Mowie
//
//  Created by Turan Yilmaz on 9.04.2021.
//

import UIKit

protocol Instantiable: AnyObject {
    static var storyboardName: String { get }
}

extension Instantiable {
    
    static func instantiateFromStoryboard() -> Self {
        let identifier = String(describing: self)
        let storyboard = UIStoryboard(name: storyboardName, bundle: Bundle(for: Self.self))
        return storyboard.instantiateViewController(withIdentifier: identifier) as! Self
    }
}
