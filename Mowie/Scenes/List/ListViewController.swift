//
//  ListViewController.swift
//  Mowie
//
//  Created by Turan Yilmaz on 27.08.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol ListDisplayLogic: AnyObject {
    func displayItems(viewModel: [AddToList.DataModel]?)
    func displayItemDetail()
}

final class ListViewController: UIViewController, ListDisplayLogic {
    var interactor: ListBusinessLogic?
    var router: (NSObjectProtocol & ListRoutingLogic & ListDataPassing)?
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var itemType: ItemType?
    var listType: ListType?
    
    var items: [AddToList.DataModel]?
    
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
        let interactor = ListInteractor()
        let presenter = ListPresenter()
        let router = ListRouter()
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
        
        guard let listType = listType, let itemType = itemType else {
            return
        }
        
        interactor?.getItems(for: listType, and: itemType)
    }
    
    // MARK: Display Logic
    
    func displayItems(viewModel: [AddToList.DataModel]?) {
        items = viewModel
        
        collectionView.register(UINib(nibName: SimilarCVCell.cellIdentifier, bundle: Bundle.main),
                                forCellWithReuseIdentifier: SimilarCVCell.cellIdentifier)

        collectionView.reloadData()
    }
    
    func displayItemDetail() {
        router?.routeToItemDetail()
    }
}

extension ListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (items?.count).intValue
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SimilarCVCell.cellIdentifier,
                                                            for: indexPath) as? SimilarCVCell else {
            return UICollectionViewCell()
        }
        
        let item = items?[indexPath.row]
        
        let model = SimilarCVCellModel(imageUrl: Utility.createImageUrl(with: (item?.posterPath).stringValue),
                                       name: item?.itemName,
                                       rate: item?.rate.stringValue,
                                       year: item?.year)
        
        cell.configure(with: model)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let item = items?[indexPath.row] else {
            return
        }
        
        let selectedItem = ItemDetail.SelectedItem(id: item.id, type: item.type, title: item.itemName)
        
        interactor?.showItemDetail(selectedItem: selectedItem)
    }
}

extension ListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = ((collectionView.frame.size.width - 10) / 3).rounded(.down)
        let height = width * 1.54
        
        return CGSize(width: width, height: height)
    }
}

extension ListViewController: Instantiable {
    static var storyboardName: String {
        return "List"
    }
}