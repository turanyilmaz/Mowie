//
//  Bool+Extension.swift
//  PinchGallery
//
//  Created by Turan Yilmaz on 12.03.2021.
//

import Foundation

extension Optional where Wrapped == Bool {
    
    var boolValue: Bool {
        return self ?? false
    }
}
