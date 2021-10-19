//
//  ListViewModel.swift
//  Mowie
//
//  Created by Turan Yilmaz on 7.04.2021.
//

import UIKit

protocol ListViewCellProtocol where Self: UITableViewCell {
    func configure(with viewModel: ListViewModelProtocol)
}

protocol ListViewModelProtocol {
    
}

struct ListViewModel {
    let sections: [ListViewSection]
    let showSeparator: Bool
    
    init(sections: [ListViewSection], showSeparator: Bool = false) {
        self.sections = sections
        self.showSeparator = showSeparator
    }
}

struct ListViewSection {
    let items: [ListViewModelProtocol]
    let cell: UITableViewCell.Type
    let cellHeight: ListViewCellHeight
    
    init(items: [ListViewModelProtocol],
         cell: UITableViewCell.Type,
         cellHeight: ListViewCellHeight = .automaticDimension) {
        self.items = items
        self.cell = cell
        self.cellHeight = cellHeight
    }
}

enum ListViewCellHeight {
    case equally
    case custom(height: CGFloat)
    case automaticDimension
}
