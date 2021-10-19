//
//  ItemCollectionViewCell.swift
//  Mowie
//
//  Created by Turan Yilmaz on 8.04.2021.
//

import UIKit
import SDWebImage

final class ItemCollectionViewCell: UICollectionViewCell, HorizontalListCellProtocol {
    
    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    
    func configure(with viewModel: HorizontalListViewModelProtocol) {
        
        guard let viewModel = viewModel as? ItemCollectionViewCellModel else {
            return
        }
        
        nameLabel.text = viewModel.name
        rateLabel.text = viewModel.rate
        yearLabel.text = viewModel.year.defaultEmptyValue
        
        bgImageView.sd_setImage(with: viewModel.imageUrl, placeholderImage: UIImage(named: "poster_placeholder"))
    }
    
    func configureCell(viewModel: Items.ViewModel) {
        nameLabel.text = viewModel.name
        rateLabel.text = viewModel.rate
        yearLabel.text = viewModel.year.defaultEmptyValue
        
        bgImageView.sd_setImage(with: viewModel.thumbnailImageUrl, placeholderImage: UIImage(named: "poster_placeholder"))
    }
}
