//
//  ListOptionView.swift
//  Mowie
//
//  Created by Turan Yilmaz on 26.08.2021.
//

import UIKit

final class ListOptionView: CustomView {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var actionImageView: UIImageView!
    @IBOutlet weak var actionContainerView: UIView!
    
    var viewModel: ListOptionViewModel? {
        didSet {
            guard let viewModel = viewModel else {
                return
            }
            
            initView(with: viewModel)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        containerView.layer.cornerRadius = containerView.frame.height/2
        actionContainerView.layer.cornerRadius = actionContainerView.frame.height/2
    }
    
    func initView(with viewModel: ListOptionViewModel) {
        
        actionImageView.image = UIImage(systemName: viewModel.list.iconName)
        actionImageView.tintColor = viewModel.list.iconTintColor
        
        let listTextAttribute = [NSAttributedString.Key.font: UIFont(name: "Avenir Black", size: 17)!]
        
        let listString = NSAttributedString(string: "'\(viewModel.list.rawValue)'", attributes: listTextAttribute)
        
        let titleAttributedString = NSMutableAttributedString(string: "\(viewModel.action.rawValue)\n")
        titleAttributedString.append(listString)
        
        titleLabel.attributedText = titleAttributedString
        
        iconImageView.image = viewModel.action.icon
        iconImageView.tintColor = viewModel.action.iconTintColor
    }
}
