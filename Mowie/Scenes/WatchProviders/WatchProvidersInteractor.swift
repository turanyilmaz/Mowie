//
//  WatchProvidersInteractor.swift
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

protocol WatchProvidersBusinessLogic {
    func getWatchProviders()
}

protocol WatchProvidersDataStore {
    var watchProviders: WatchProviders? { get set }
}

final class WatchProvidersInteractor: WatchProvidersBusinessLogic, WatchProvidersDataStore {
    var presenter: WatchProvidersPresentationLogic?
    var worker: WatchProvidersWorker?
    
    var watchProviders: WatchProviders?
   
    func getWatchProviders() {
        presenter?.presentWatchProviders(watchProviders: watchProviders)
    }
}
