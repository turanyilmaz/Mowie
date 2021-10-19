//
//  CustomView.swift
//  Mowie
//
//  Created by Turan Yilmaz on 7.04.2021.
//

import UIKit

class CustomView: UIView {
    
    override init(frame:CGRect) {
        super.init(frame:frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        let nibName = String(describing: type(of: self))
        let uiNib = UINib(nibName: nibName, bundle: Bundle.main)
        let view = uiNib.instantiate(withOwner: self, options: nil).first as! UIView
        
        
        self.addSubview(view)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([view.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                                     view.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                                     view.topAnchor.constraint(equalTo: self.topAnchor),
                                     view.bottomAnchor.constraint(equalTo: self.bottomAnchor)])
    }
}
