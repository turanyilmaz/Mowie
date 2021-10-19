//
//  SimilarCVCell.swift
//  Mowie
//
//  Created by Turan Yilmaz on 14.04.2021.
//

import UIKit

final class SimilarCVCell: UICollectionViewCell {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    
    func configure(with viewModel: SimilarCVCellModel) {
        
        posterImageView.sd_setImage(with: viewModel.imageUrl,
                                    placeholderImage: UIImage(named: "poster_placeholder.png"))
        nameLabel.text = viewModel.name
        rateLabel.text = viewModel.rate
    }

}
