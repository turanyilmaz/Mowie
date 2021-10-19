//
//  Int+Extension.swift
//  PinchGallery
//
//  Created by Turan Yilmaz on 12.03.2021.
//

import Foundation

extension Optional where Wrapped == Int {
    
    var intValue: Int {
        return self ?? 0
    }
    
    var stringValue: String {
        return String(self.intValue)
    }
}
