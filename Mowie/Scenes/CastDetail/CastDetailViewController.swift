//
//  CastDetailViewController.swift
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

protocol CastDetailDisplayLogic: BaseDisplayLogic {
    func displayCastDetail(viewModel: CastDetail.GetCast.ViewModel)
    func displayTitle(title: String?)
    func displayItemDetail(selectedItem: ItemDetail.SelectedItem?)
}

final class CastDetailViewController: BaseViewController, CastDetailDisplayLogic {
    var interactor: CastDetailBusinessLogic?
    var router: (NSObjectProtocol & CastDetailRoutingLogic & CastDetailDataPassing)?
    
    @IBOutlet weak var listView: ListView!
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = CastDetailInteractor()
        let presenter = CastDetailPresenter()
        let router = CastDetailRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
        
        interactor.basePresenter = presenter
        presenter.baseViewController = viewController
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        interactor?.setTitle()
        interactor?.getCastDetail()
    }
    
    func displayCastDetail(viewModel: CastDetail.GetCast.ViewModel) {
        listView.viewModel = viewModel.listViewModel
    }
    
    func displayTitle(title: String?) {
        self.title = title
    }
    
    func displayItemDetail(selectedItem: ItemDetail.SelectedItem?) {
        router?.routeToItemDetail(selectedItem: selectedItem)
    }
}

extension CastDetailViewController: Instantiable {
    static var storyboardName: String {
        return "CastDetail"
    }
}
