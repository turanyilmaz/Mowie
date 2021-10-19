//
//  CastCVCell.swift
//  Mowie
//
//  Created by Turan Yilmaz on 14.04.2021.
//

import UIKit

class CastCVCell: UICollectionViewCell, HorizontalListCellProtocol {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    func configure(with viewModel: HorizontalListViewModelProtocol) {
        guard let viewModel = viewModel as? CastCVCellModel else {
            return
        }
        
        imageView.sd_setImage(with: viewModel.imageUrl, placeholderImage: UIImage(systemName: "person.fill"))
        nameLabel.text = viewModel.name
    }
}
