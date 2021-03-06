//
//  WatchProvidersPresenter.swift
//  Mowie
//
//  Created by Turan Yilmaz on 2.09.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol WatchProvidersPresentationLogic {
    func presentWatchProviders(watchProviders: WatchProviders?)
}

final class WatchProvidersPresenter: WatchProvidersPresentationLogic {
    weak var viewController: WatchProvidersDisplayLogic?
    
    func presentWatchProviders(watchProviders: WatchProviders?) {
        
        var countryCode = "US"
        
        if let regionCode = NSLocale.current.regionCode {
            countryCode = regionCode
        }
        
        let providers = watchProviders?.results[countryCode]
        let url = URL(string: (providers?.link).stringValue)
        
        
        //Flatrate
        
        let flatrateModels = providers?.flatrate?.map({ flatrate in
            WatchProviderCellModel(logoUrl: Utility.createImageUrl(with: (flatrate.logoPath).stringValue),
                                   name: flatrate.providerName)
        })
        
        
        
        let flatrateHlViewModel = HorizontalListViewModel(items: flatrateModels,
                                                          itemCount: 5,
                                                          cellAspectRatio: 1,
                                                          title: "Flatrate",
                                                          cell: WatchProviderCVCell.self,
                                                          didSelectCallback: nil)
        
        let flatrateHlCellModel = HorizontalListCellModel(horizontalListViewModel: flatrateHlViewModel)
        
        let flatrateSection = ListViewSection(items: [flatrateHlCellModel],
                                              cell: HorizontalListCell.self,
                                              cellHeight: .custom(height: 200))
        
        //Buy
        
        let buyModels = providers?.buy?.map({ buy in
            WatchProviderCellModel(logoUrl: Utility.createImageUrl(with: (buy.logoPath).stringValue),
                                   name: buy.providerName)
        })



        let buyHlViewModel = HorizontalListViewModel(items: buyModels,
                                                     itemCount: 3,
                                                     cellAspectRatio: 1,
                                                     title: "Buy",
                                                     cell: WatchProviderCVCell.self,
                                                     didSelectCallback: nil)

        let buyHlCellModel = HorizontalListCellModel(horizontalListViewModel: buyHlViewModel)

        let buySection = ListViewSection(items: [buyHlCellModel],
                                         cell: HorizontalListCell.self,
                                         cellHeight: .custom(height: 500))
        
        //Rent
        
        let rentModels = providers?.rent?.map({ rent in
            WatchProviderCellModel(logoUrl: Utility.createImageUrl(with: (rent.logoPath).stringValue),
                                   name: rent.providerName)
        })



        let rentHlViewModel = HorizontalListViewModel(items: rentModels,
                                                     itemCount: 5,
                                                     cellAspectRatio: 1,
                                                     title: "Rent",
                                                     cell: WatchProviderCVCell.self,
                                                     didSelectCallback: nil)

        let rentHlCellModel = HorizontalListCellModel(horizontalListViewModel: rentHlViewModel)

        let rentSection = ListViewSection(items: [rentHlCellModel],
                                          cell: HorizontalListCell.self,
                                          cellHeight: .custom(height: 200))
        
        //FlatrateAndBuy
        
        let flatrateAndBuyModels = providers?.flatrateAndBuy?.map({ flatrateAndBuy in
            WatchProviderCellModel(logoUrl: Utility.createImageUrl(with: (flatrateAndBuy.logoPath).stringValue),
                                   name: flatrateAndBuy.providerName)
        })
        
        
        
        let flatrateAndBuyHlViewModel = HorizontalListViewModel(items: flatrateAndBuyModels,
                                                     itemCount: 5,
                                                     cellAspectRatio: 1,
                                                     title: "Flatrate and Buy",
                                                     cell: WatchProviderCVCell.self,
                                                     didSelectCallback: nil)
        
        let flatrateAndBuyHlCellModel = HorizontalListCellModel(horizontalListViewModel: flatrateAndBuyHlViewModel)
        
        let flatrateAndBuySection = ListViewSection(items: [flatrateAndBuyHlCellModel],
                                                    cell: HorizontalListCell.self,
                                                    cellHeight: .custom(height: 200))
        
        
        let viewModel = ListViewModel(sections: [flatrateSection, buySection, rentSection, flatrateAndBuySection])
        viewController?.displayWatchProviders(viewModel: viewModel)
    }
}
