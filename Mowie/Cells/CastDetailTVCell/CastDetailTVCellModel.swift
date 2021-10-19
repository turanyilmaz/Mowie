//
//  CastDetailTVCellModel.swift
//  Mowie
//
//  Created by Turan Yilmaz on 22.04.2021.
//

import UIKit

struct CastDetailTVCellModel: ListViewModelProtocol {
    let imageURL: URL?
    let name: String?
    let birthDate: String?
    let homeTown: String?
    let moviesCount: String?
    let tvsCount: String?
    let externalIds: ExternalIDS?
}
