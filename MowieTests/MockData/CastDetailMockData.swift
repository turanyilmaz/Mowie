//
//  CastDetailMockData.swift
//  MovilienTests
//
//  Created by Turan Yilmaz on 3.05.2021.
//

import Foundation
@testable import Mowie

struct CastDetailMockData {
    static let detailResponse = CastDetail.GetCast.Response(id: nil,
                                                            birthday: nil,
                                                            name: nil,
                                                            biography: nil,
                                                            homeTown: nil,
                                                            profileImage: nil,
                                                            movieCredits: nil,
                                                            tvCredits: nil,
                                                            externalIds: nil)
    
    static let selectedItem = ItemDetail.SelectedItem(id: nil, type: .movie, title: nil)
    
    static let listViewModel = ListViewModel(sections: [])
}
