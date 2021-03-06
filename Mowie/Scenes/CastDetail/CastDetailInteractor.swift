//
//  CastDetailInteractor.swift
//  Mowie
//
//  Created by Turan Yilmaz on 22.04.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol CastDetailBusinessLogic: BaseBusinessLogic {
    func getCastDetail()
    func setTitle()
}

protocol CastDetailDataStore {
    var selectedCast: CastDetail.SelectedCast? { get set }
}

final class CastDetailInteractor: BaseInteractor, CastDetailBusinessLogic, CastDetailDataStore {
    var presenter: CastDetailPresentationLogic?
    var worker: CastDetailWorker = CastDetailWorker(castDetailService: CastDetailService())
    
    var selectedCast: CastDetail.SelectedCast?
    
    func getCastDetail() {
        let request = CastDetail.GetCast.Request(castId: (selectedCast?.id).intValue)

        worker.getCastDetail(request: request) { (result) in
            switch result {
            case .success(let response):
                self.presenter?.presentCastDetail(response: response)
            case .failure(let error):
                self.showErrorAlert(error: error)
            }
        }
    }
    
    func setTitle() {
        presenter?.presentTitle(title: selectedCast?.name)
    }
}
