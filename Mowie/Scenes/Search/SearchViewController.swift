//
//  SearchViewController.swift
//  Mowie
//
//  Created by Turan Yilmaz on 13.08.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit
import youtube_ios_player_helper

protocol SearchDisplayLogic: BaseDisplayLogic {
    func displaySearchResult(viewModel: ListViewModel)
    func displayItemDetail()
    func displayPersonDetail()
}

final class SearchViewController: BaseViewController, SearchDisplayLogic {
    var interactor: SearchBusinessLogic?
    var router: (NSObjectProtocol & SearchRoutingLogic & SearchDataPassing)?
    
    @IBOutlet weak var showOptionButton: UIButton!
    @IBOutlet weak var buttonStackView: UIStackView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var listView: ListView!
    @IBOutlet weak var searchOptionsView: UIView!
    @IBOutlet weak var optionsButtonStackView: UIStackView!
    
    var options = [UIButton]()
    var isSelectionMode: Bool = false
    var searchType: SearchType = .movie
    var page: Int = 1
    var searchText: String?
    var isLoading = false
    var scrollViewOffset: CGFloat = 0.0
    
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
        let interactor = SearchInteractor()
        let presenter = SearchPresenter()
        let router = SearchRouter()
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
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(showOptionsButtonTapped))
        buttonStackView.addGestureRecognizer(tapGesture)
        
        searchBar.delegate = self
        listView.delegate = self
        listView.didSelectCallback = didSelectCallback(selectedItem:)
        
        options = optionsButtonStackView.arrangedSubviews as? [UIButton] ?? []
        options.forEach { button in
            button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 8)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        searchBar.becomeFirstResponder()
    }
    
    private func didSelectCallback(selectedItem: ListViewModelProtocol) {
        guard let selectedItem = selectedItem as? SearchTableViewCellModel else {
            return
        }
        
        if selectedItem.resultType == .person {
            interactor?.showPersonDetail(selectedItem: selectedItem)
        } else {
            interactor?.showItemDetail(selectedItem: selectedItem)
        }
    }
    
    @objc
    private func showOptionsButtonTapped() {
        setSearchOptionsViewVisibility()
    }
    
    private func setSearchOptionsViewVisibility() {
        UIView.animate(withDuration: 0.2) {
            self.searchOptionsView.isHidden = !self.searchOptionsView.isHidden
        }
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        setSearchOptionsViewVisibility()
        searchType = SearchType(rawValue: sender.accessibilityIdentifier.stringValue) ?? .movie
        showOptionButton.setImage(searchType.icon, for: .normal)
        searchBar.placeholder = searchType.placeHolder
        
        if let searchText = searchText, !searchText.isEmpty {
            interactor?.getSearchResult(searchType: searchType, query: searchText, page: 1)
        }
    }
    
    //MARK: Display Logic
    
    func displaySearchResult(viewModel: ListViewModel) {
        isLoading = false
        listView.viewModel = viewModel
    }
    
    func displayItemDetail() {
        router?.routeToItemDetail()
    }
    
    func displayPersonDetail() {
        router?.routeToPersonDetail()
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchText = searchText
        
        if !searchText.isEmpty {
            interactor?.getSearchResult(searchType: searchType, query: searchText, page: 1)
        } else {
            listView.viewModel = nil
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
}

extension SearchViewController: ListViewDelegate {
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        view.endEditing(true)
        
        let offset = scrollView.contentOffset.y
        
        let dd = (scrollView.contentSize.height - scrollView.frame.size.height) - 60
        if dd > 0, offset >= dd, !isLoading {
            isLoading = true
            page += 1
            interactor?.getSearchResult(searchType: searchType, query: searchText.stringValue, page: page)
        }
    }
}

extension SearchViewController: Instantiable {
    static var storyboardName: String {
        return "Search"
    }
}


