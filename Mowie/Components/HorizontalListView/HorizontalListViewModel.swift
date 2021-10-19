//
//  HorizontalListViewModel.swift
//  Mowie
//
//  Created by Turan Yilmaz on 13.04.2021.
//

import UIKit

protocol HorizontalListCellProtocol where Self: UICollectionViewCell {
    func configure(with viewModel: HorizontalListViewModelProtocol)
}

protocol HorizontalListViewModelProtocol {
    
}

struct HorizontalListViewModel {
    let items: [HorizontalListViewModelProtocol]?
    let itemCount: Int //per page
    let cellAspectRatio: CGFloat //for cell height
    let title: String?
    let cell: UICollectionViewCell.Type
    
    let didSelectCallback: ((Int) -> Void)?
}
