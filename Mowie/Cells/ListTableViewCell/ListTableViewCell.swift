//
//  ListTableViewCell.swift
//  Mowie
//
//  Created by Turan Yilmaz on 27.08.2021.
//

import UIKit

final class ListTableViewCell: UITableViewCell, ListViewCellProtocol {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconBackgroundView: UIView!
    
    func configure(with viewModel: ListViewModelProtocol) {
        guard let viewModel = viewModel as? ListTableViewCellModel else {
            return
        }
        
        iconImageView.image = UIImage(systemName: viewModel.list.iconName)
        iconImageView.tintColor = viewModel.list.iconTintColor
        iconBackgroundView.backgroundColor = viewModel.list.iconTintColor
        titleLabel.text = viewModel.list.rawValue
    }
    
}
