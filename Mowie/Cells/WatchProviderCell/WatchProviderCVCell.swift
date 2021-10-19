//
//  WatchProviderCVCell.swift
//  Mowie
//
//  Created by Turan Yilmaz on 2.09.2021.
//

import UIKit

final class WatchProviderCVCell: UICollectionViewCell, HorizontalListCellProtocol {

    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    func configure(with viewModel: HorizontalListViewModelProtocol) {
        guard let viewModel = viewModel as? WatchProviderCellModel else {
            return
        }
        
        logoImageView.sd_setImage(with: viewModel.logoUrl, placeholderImage: UIImage(systemName: "person.fill"))
        nameLabel.text = viewModel.name
    }
    

}
