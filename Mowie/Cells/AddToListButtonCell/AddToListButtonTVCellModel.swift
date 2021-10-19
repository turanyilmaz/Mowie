//
//  AddToListTVCellModel.swift
//  Mowie
//
//  Created by Turan Yilmaz on 15.04.2021.
//

import Foundation

struct AddToListButtonTVCellModel: ListViewModelProtocol {
    var title: String?
    let addButtonTappedCallback: (() -> Void)?
    let watchButtonTappedCallback: (() -> Void)?
}
