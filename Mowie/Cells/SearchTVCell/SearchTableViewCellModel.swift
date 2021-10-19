//
//  SearchTableViewCellModel.swift
//  Mowie
//
//  Created by Turan Yilmaz on 16.08.2021.
//

import Foundation

struct SearchTableViewCellModel: ListViewModelProtocol {
    let id: Int?
    let imageUrl: URL?
    let title: String?
    let subTitle: String?
    let rate: String?
    let resultType: SearchType?
}
