//
//  Double+Extension.swift
//  Mowie
//
//  Created by Turan Yilmaz on 9.04.2021.
//

import Foundation

extension Optional where Wrapped == Double {
    
    var doubleValue: Double {
        return self ?? 0.0
    }
    
    var stringValue: String {
        return String(self.doubleValue)
    }
}
