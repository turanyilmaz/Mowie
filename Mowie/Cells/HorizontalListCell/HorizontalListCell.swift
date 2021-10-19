//
//  HorizontalListCell.swift
//  Mowie
//
//  Created by Turan Yilmaz on 14.04.2021.
//

import UIKit

final class HorizontalListCell: UITableViewCell, ListViewCellProtocol {
    
    @IBOutlet weak var horizontalListView: HorizontalListView!
    
    func configure(with viewModel: ListViewModelProtocol) {
        guard let viewModel = viewModel as? HorizontalListCellModel else {
            return
        }
        
        horizontalListView.viewModel = viewModel.horizontalListViewModel
    }
}
