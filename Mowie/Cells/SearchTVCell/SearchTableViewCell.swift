//
//  SearchTableViewCell.swift
//  Mowie
//
//  Created by Turan Yilmaz on 16.08.2021.
//

import UIKit

final class SearchTableViewCell: UITableViewCell, ListViewCellProtocol {
    
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var rateStackView: UIStackView!
    
    
    func configure(with viewModel: ListViewModelProtocol) {
        guard let viewModel = viewModel as? SearchTableViewCellModel else {
            return
        }
        
        if viewModel.resultType == .person {
            itemImageView.sd_setImage(with: viewModel.imageUrl,
                                      placeholderImage: UIImage(systemName: "person.fill"))
        } else {
            itemImageView.sd_setImage(with: viewModel.imageUrl,
                                      placeholderImage: UIImage(named: "poster_placeholder"))
        }
        
        
        titleLabel.text = viewModel.title
        subtitleLabel.text = viewModel.subTitle.defaultEmptyValue
        rateLabel.text = viewModel.rate
        
        rateStackView.isHidden = viewModel.rate == nil
    }
    
    
    
}
