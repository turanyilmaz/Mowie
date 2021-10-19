//
//  AddToListTableViewCell.swift
//  Mowie
//
//  Created by Turan Yilmaz on 25.08.2021.
//

import UIKit

final class AddToListTableViewCell: UITableViewCell, ListViewCellProtocol {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    func configure(with viewModel: ListViewModelProtocol) {
        guard let viewModel = viewModel as? AddToListTableViewCellModel else {
            return
        }
        
        iconImageView.image = UIImage(named: viewModel.iconName.stringValue)
        titleLabel.text = viewModel.title
    }

}
