//
//  AddToListInteractor.swift
//  Mowie
//
//  Created by Turan Yilmaz on 24.08.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol AddToListBusinessLogic {
//    func saveItem(to list: ListType)
    func showOptions()
    func databaseAction(list: ListType, action: ListAction)
}

protocol AddToListDataStore {
    var addToListDataModel: AddToList.DataModel? { get set }
    var selectedList: ListType? { get set }
}

final class AddToListInteractor: AddToListBusinessLogic, AddToListDataStore {
    var presenter: AddToListPresentationLogic?
    var worker: AddToListWorker?
    
    var addToListDataModel: AddToList.DataModel?
    var selectedList: ListType?
    
    func databaseAction(list: ListType, action: ListAction) {
        
        guard let item = addToListDataModel, let itemId = item.id else {
            return
        }
        
        switch action {
        case .add:
            DatabaseManager.shared.save(item: item, to: list)
        case .move:
            DatabaseManager.shared.moveItem(to: list, by: itemId)
        case .remove:
            DatabaseManager.shared.deleteItem(by: itemId)
        }
        
        presenter?.presentSavedItemState(for: list, action: action)
    }
    
//    func saveItem(to list: ListType) {
//
//        guard let item = addToListDataModel else {
//            return
//        }
//
//        DatabaseManager.shared.save(item: item, to: list)
//
//        presenter?.presentSavedItemState(for: list)
//    }
    
    func showOptions() {
        presenter?.presentOptions(with: addToListDataModel)
    }
}
