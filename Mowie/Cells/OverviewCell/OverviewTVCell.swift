//
//  OverviewTVCell.swift
//  Mowie
//
//  Created by Turan Yilmaz on 13.04.2021.
//

import UIKit

final class OverviewTVCell: UITableViewCell, ListViewCellProtocol {

    @IBOutlet weak var overviewTitleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!

    func configure(with viewModel: ListViewModelProtocol) {
        guard let viewModel = viewModel as? OverviewTVCellModel else {
            return
        }
        
        overviewTitleLabel.text = viewModel.title
        
        overviewLabel.text = viewModel.overviewText
    }
}
