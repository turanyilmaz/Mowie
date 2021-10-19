//
//  String+Extension.swift
//  PinchGallery
//
//  Created by Turan Yilmaz on 5.03.2021.
//

import UIKit
import Foundation

extension Optional where Wrapped == String {
    
    var stringValue: String {
        return self ?? ""
    }
    
    var defaultEmptyValue: String {
        return self ?? "-"
    }
}


