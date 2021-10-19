//
//  HorizontalListView.swift
//  Mowie
//
//  Created by Turan Yilmaz on 13.04.2021.
//

import UIKit

final class HorizontalListView: CustomView {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var titleLabel: UILabel!
    
    private let defaultItemCount: Int = 4
    private let spaceBetweenCells: CGFloat = 8.0
    private var cellSize: CGSize = .zero
    
    var viewModel: HorizontalListViewModel? {
        didSet {
            if let viewModel = viewModel {
                initView(with: viewModel)
            }
        }
    }
    
    func initView(with viewModel: HorizontalListViewModel) {
        
        titleLabel.text = viewModel.title
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        
        
        let cellIdentifier = viewModel.cell.cellIdentifier
        collectionView.register(UINib(nibName: cellIdentifier, bundle: Bundle.main), forCellWithReuseIdentifier: cellIdentifier)
        collectionView.reloadData()
        collectionView.layoutIfNeeded()
    }
}

extension HorizontalListView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        let itemCount = CGFloat(viewModel?.itemCount ?? defaultItemCount)
        let totalSpaces = spaceBetweenCells * itemCount
        let width = ((collectionView.frame.size.width - totalSpaces) / itemCount)
//        let height = width * (viewModel?.cellAspectRatio ?? 2.0)
        let height = collectionView.frame.height
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return spaceBetweenCells
    }
}

extension HorizontalListView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (viewModel?.items?.count).intValue
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let viewModel = viewModel, let items = viewModel.items else {
            return UICollectionViewCell()
        }
        
        let model = items[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: viewModel.cell.cellIdentifier, for: indexPath) as! HorizontalListCellProtocol
        
        cell.configure(with: model)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Did select collection view")
        viewModel?.didSelectCallback?(indexPath.row)
    }
}
