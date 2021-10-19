//
//  SearchPresenter.swift
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

protocol SearchPresentationLogic: BasePresentationLogic {
    func presentMovieResult(response: Search.Movie.Response)
    func presentTVResult(response: Search.TV.Response)
    func presentPersonResult(response: Search.Person.Response)
    func presentItemDetail()
    func presentPersonDetail()
}

final class SearchPresenter: BasePresenter, SearchPresentationLogic {
    weak var viewController: SearchDisplayLogic?
    
    var items = [SearchTableViewCellModel]()
    
    //MARK: Present Search Results
    
    func presentSearchResult(results: [SearchTableViewCellModel], isNewPage: Bool) {
        if !isNewPage {
            items.removeAll()
        }
        
        items.append(contentsOf: results)
        
        let listViewModel = ListViewModel(sections: [ListViewSection(items: items,
                                                                     cell: SearchTableViewCell.self)],
                                          showSeparator: true)
        viewController?.displaySearchResult(viewModel: listViewModel)
    }
    
    func presentMovieResult(response: Search.Movie.Response) {
        
        let results = response.results.map { (movie) -> SearchTableViewCellModel in
            SearchTableViewCellModel(id: movie.id,
                                     imageUrl: Utility.createImageUrl(with: movie.posterPath.stringValue),
                                     title: movie.title,
                                     subTitle: Utility.getYearFromDateString(string: movie.releaseDate),
                                     rate: movie.voteAverage.stringValue,
                                     resultType: .movie)
        }
        
        presentSearchResult(results: results, isNewPage: response.page.intValue > 1)
    }
    
    func presentTVResult(response: Search.TV.Response) {
        let results = response.results.map { (tv) -> SearchTableViewCellModel in
            SearchTableViewCellModel(id: tv.id,
                                     imageUrl: Utility.createImageUrl(with: tv.posterPath.stringValue),
                                     title: tv.name,
                                     subTitle: Utility.getYearFromDateString(string: tv.firstAirDate),
                                     rate: tv.voteAverage.stringValue,
                                     resultType: .tv)
        }
        
        presentSearchResult(results: results, isNewPage: response.page.intValue > 1)
    }
    
    func presentPersonResult(response: Search.Person.Response) {
        let results = response.results.map { (person) -> SearchTableViewCellModel in
            SearchTableViewCellModel(id: person.id,
                                     imageUrl: Utility.createImageUrl(with: person.profileImagePath),
                                     title: person.name,
                                     subTitle: person.department,
                                     rate: nil,
                                     resultType: .person)
        }
        
        presentSearchResult(results: results, isNewPage: response.page.intValue > 1)
    }
    
    //MARK: Present Item Detail
    
    func presentItemDetail() {
        viewController?.displayItemDetail()
    }
    
    func presentPersonDetail() {
        viewController?.displayPersonDetail()
    }
}