//
//  ActivityIndicatorManager.swift
//  Mowie
//
//  Created by Turan Yilmaz on 29.09.2021.
//

import UIKit

final class ActivityIndicatorManager {
    
    static let shared = ActivityIndicatorManager()
    
    private init() {
        UIApplication.shared.keyWindow?.addSubview(indicator)
    }
    
    private var indicator: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        view.backgroundColor = .clear
        
        let indicatorView = UIActivityIndicatorView(style: .large)
        indicatorView.color = UIColor(named: "mainOrange")
        indicatorView.startAnimating()
        indicatorView.center = view.center
        view.addSubview(indicatorView)
        
        return view
    }()
    
    func showIndicator() {
        indicator.isHidden = false
    }
    
    func hideIndicator() {
        indicator.isHidden = true
    }
}
