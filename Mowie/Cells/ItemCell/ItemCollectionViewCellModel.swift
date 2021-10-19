//
//  ItemCollectionViewCellModel.swift
//  Mowie
//
//  Created by Turan Yilmaz on 26.04.2021.
//

import Foundation

struct ItemCollectionViewCellModel: HorizontalListViewModelProtocol {
    let id: Int?
    let imageUrl: URL?
    let name: String?
    let rate: String?
    let year: String?
    let type: ItemType
    
    init(id: Int?,
         imageUrl: URL?,
         name: String?,
         rate: Double?,
         year: String?,
         type: ItemType) {
        self.id = id
        self.imageUrl = imageUrl
        self.name = name
        self.rate = String(format: "%.1f", ceil(rate.doubleValue*100)/100)
        self.year = year
        self.type = type
    }
}
