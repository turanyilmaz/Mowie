//
//  WatchProvidersViewController.swift
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

protocol WatchProvidersDisplayLogic: AnyObject {
    func displayWatchProviders(viewModel: ListViewModel)
}

final class WatchProvidersViewController: UIViewController, WatchProvidersDisplayLogic {
    var interactor: WatchProvidersBusinessLogic?
    var router: (NSObjectProtocol & WatchProvidersRoutingLogic & WatchProvidersDataPassing)?
    
    // MARK: Object lifecycle
    
    @IBOutlet weak var listView: ListView!
    
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
        let interactor = WatchProvidersInteractor()
        let presenter = WatchProvidersPresenter()
        let router = WatchProvidersRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        interactor?.getWatchProviders()
    }
    
    func displayWatchProviders(viewModel: ListViewModel) {
        listView.viewModel = viewModel
    }
}

extension WatchProvidersViewController: Instantiable {
    static var storyboardName: String {
        return "WatchProviders"
    }
}
