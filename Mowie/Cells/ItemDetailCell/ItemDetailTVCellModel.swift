//
//  ItemDetailTVCellModel.swift
//  Mowie
//
//  Created by Turan Yilmaz on 14.04.2021.
//

import UIKit

struct ItemDetailTVCellModel: ListViewModelProtocol {
    
    let voteAverage: String?
    let posterImageUrl: URL?
    let title: String?
    let releaseDate: String?
    let numberOfSeason: Int?
    var runtime: String?
    let language: String?
    let genres: String?
    let backdropImageUrl: URL?
    let selectedList: ListType?
    let hidePlayTrailerButton: Bool
    let trailerButtonTappedCallback: (() -> Void)?
}
