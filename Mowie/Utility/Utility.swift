//
//  Utility.swift
//  Mowie
//
//  Created by Turan Yilmaz on 8.04.2021.
//

import UIKit

struct Utility {
    
    static func getDeviceLanguage() -> String {
        return Locale.preferredLanguages[0]
    }
    
    static func getYearFromDateString(string: String?) -> String? {
        
        guard let string = string, !string.isEmpty else {
            return nil
        }
        
        let components = string.components(separatedBy: "-")
        
        return components[0]
    }
    
    static func createImageUrl(with string: String?) -> URL? {
        guard let string = string, !string.isEmpty else {
            return nil
        }
        
        let urlString = Constants.thumbnailBaseUrl + string
        return URL(string: urlString)
    }
    
    static func createGenresText(with genres: [Genres.Genre]?) -> String? {
        
        guard let genres = genres, !genres.isEmpty else {
            return nil
        }
        
        var genreText = ""

        for (index, genre) in genres.enumerated() {
            if index != 3 {
                genreText += genre.name
                
                if index != genres.count - 1 && index != 2 {
                    genreText += ", "
                }
            } else {
                break
            }
        }
        
        return genreText
    }
    
    static func createPages(for type: ItemType) -> (viewControllers: [UIViewController], titles: [String]) {
        
        var viewControllers: [UIViewController] = []
        var barItemTitles: [String] = []
        
        var categories: [CategoryProtocol]
        
        if type == .movie {
            categories = [MovieCategory.popular, MovieCategory.topRated, MovieCategory.nowPlaying, MovieCategory.upComing]
        } else {
            categories = [TVCategory.popular, TVCategory.topRated, TVCategory.airingToday, TVCategory.onTheAir]
        }
        
        let genresVC = GenresViewController.instantiateFromStoryboard()
        genresVC.genreListType = type
        viewControllers.append(genresVC)
        
        for i in categories {
            let itemsVC = ItemsViewController.instantiateFromStoryboard()
            var dataStore = itemsVC.router!.dataStore!
            dataStore.itemListType = type == .movie ? .movie(.category(i)) : .tv(.category(i))
//            itemsVC.itemListType = type == .movie ? .movie(.category(i)) : .tv(.category(i))
            viewControllers.append(itemsVC)
        }
        
        //Creating bar item titles
        
        barItemTitles.append("GENRES")
        
        for category in categories {
            barItemTitles.append(category.title)
        }
        
        return (viewControllers, barItemTitles)
    }
    
    static func getGenreImageUrl(with genreId: Int, for type: ItemType) -> URL? {
        var imageUrl: URL? = nil
        
        if type == .movie {
            imageUrl = URL(string: Constants.backdropBaseUrl + Constants.movieGenreImages[genreId].stringValue)
        } else {
            imageUrl = URL(string: Constants.backdropBaseUrl + Constants.tvGenreImages[genreId].stringValue)
        }
        return imageUrl
    }
    
    static func getItemDetailViewController(viewController: UIViewController) -> ItemDetailViewController? {
        if let vc = ((viewController.presentingViewController as? TabBarViewController)?.selectedViewController as? UINavigationController)?.viewControllers[1] as? ItemDetailViewController {
            return vc
        }
        return nil
    }
    
    static func parseForTrailerVideo(videos: [Video]?) -> String? {
        
        let video = videos?.filter { video in
            return video.type == "Trailer"
        }.first
        
        if let videoId = video?.key, !videoId.isEmpty {
            return videoId
        }
        
        return nil
    }
    
    static func getAppVersion() -> String? {
        if let bundleVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String {
            return "version \(bundleVersion)"
        }
        return nil
    }
}
