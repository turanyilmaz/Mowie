//
//  GenresTableViewCell.swift
//  Mowie
//
//  Created by Turan Yilmaz on 7.04.2021.
//

import UIKit

final class GenresTableViewCell: UITableViewCell, ListViewCellProtocol {
   
    @IBOutlet weak var genreImageView: UIImageView!
    @IBOutlet weak var genreNameLabel: UILabel!
    
    func configure(with viewModel: ListViewModelProtocol) {
        guard let viewModel = viewModel as? Genres.GetGenres.ViewModel else {
            return
        }
        
        genreImageView.sd_setImage(with: viewModel.imageUrl)
        genreNameLabel.text = viewModel.name
    }
}
