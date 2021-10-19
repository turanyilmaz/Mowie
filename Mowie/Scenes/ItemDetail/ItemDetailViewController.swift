//
//  ItemDetailViewController.swift
//  Mowie
//
//  Created by Turan Yilmaz on 14.04.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol ItemDetailDisplayLogic: BaseDisplayLogic {
    func displayItemDetail(viewModel: ItemDetail.GetItemDetail.ViewModel, selectedList: ListType?)
    func displayRecommendItemDetail(selectedItem: ItemDetail.SelectedItem?)
    func displayItemTitle(title: String?)
    func displayCastDetail(with castId: Int, and castName: String)
    func displayAddToListOptions()
    func displayWatchProviders()
    
    func trailerButtonTappedCallback()
    func addToListButtonTappedCallback()
    func watchButtonTappedCallback()
}

final class ItemDetailViewController: BaseViewController, ItemDetailDisplayLogic {
    var interactor: ItemDetailBusinessLogic?
    var router: (NSObjectProtocol & ItemDetailRoutingLogic & ItemDetailDataPassing)?
    
    @IBOutlet weak var listView: ListView!
    
    var viewModel: ItemDetail.GetItemDetail.ViewModel?
    
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
        let interactor = ItemDetailInteractor()
        let presenter = ItemDetailPresenter()
        let router = ItemDetailRouter()
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
        
        interactor?.setItemTitle()
        interactor?.getItemDetail()
        
        listView.didSelectCallback = nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(listDidSelect(notification:)),
                                               name: NSNotification.Name("listSelected"),
                                               object: nil)
    }
    
    func displayItemDetail(viewModel: ItemDetail.GetItemDetail.ViewModel, selectedList: ListType?) {
        listView.viewModel = viewModel.listViewModel
        
        self.viewModel = viewModel

        setRightBarButton(for: selectedList)
    }
    
    func displayItemTitle(title: String?) {
        self.title = title
    }
    
    func displayCastDetail(with castId: Int, and castName: String) {
        router?.routeToCastDetail(with: castId, and: castName)
    }
    
    func displayRecommendItemDetail(selectedItem: ItemDetail.SelectedItem?) {
        router?.routeToSimilarItemDetail(selectedItem: selectedItem)
    }
    
    func displayAddToListOptions() {
        router?.routeToAddToListOptions()
    }
    
    func displayWatchProviders() {
        router?.routeToWatchProviders()
    }
    
    func setRightBarButton(for list: ListType?) {
        guard let list = list else {
            navigationItem.rightBarButtonItems = nil
            return
        }
        
        let listIconButton = UIBarButtonItem(image: UIImage(systemName: list.iconName),
                                             style: .plain,
                                             target: self,
                                             action: #selector(addToListButtonTappedCallback))
        listIconButton.tintColor = list.iconTintColor
        navigationItem.rightBarButtonItems = [listIconButton]
    }
    
    func trailerButtonTappedCallback() {
        router?.routeToTrailers()
    }
    
    @objc
    func addToListButtonTappedCallback() {
        interactor?.showAddToListOptions()
    }
    
    @objc
    func watchButtonTappedCallback() {
        interactor?.showWatchProviders()
    }
    
    @objc
    func listDidSelect(notification: Notification) {
        
        if let selectedList = notification.userInfo?["selectedList"] as? ListType,
           let action = notification.userInfo?["action"] as? ListAction {
            interactor?.changeSelectedList(newList: action == .remove ? nil : selectedList)
        }
    }
}

extension ItemDetailViewController: Instantiable {
    static var storyboardName: String {
        return "ItemDetail"
    }
}
