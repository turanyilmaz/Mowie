//
//  Constants.swift
//  Mowie
//
//  Created by Turan Yilmaz on 8.04.2021.
//

import UIKit

struct Constants {
    
    static let apiKey: String = "31b2377287f733ce461c2d352a64060e"
    static let baseURL: String = "https://api.themoviedb.org/3"
    static let constantUrlComponent: String = "?api_key=\(Constants.apiKey)&language=\(Utility.getDeviceLanguage())"
    static let thumbnailBaseUrl: String = "https://image.tmdb.org/t/p/w185"
    static let backdropBaseUrl: String = "https://image.tmdb.org/t/p/w780"
    
    static let denemeLiink = "https://www.themoviedb.org/movie/385128-f9/watch?locale=AU"
}

enum ItemType: String {
    case movie = "Movie"
    case tv = "TV"
}

enum SearchType: String {
    case movie
    case tv
    case person
    
    var placeHolder: String {
        switch self {
        case .movie:
            return "Search movie"
        case .tv:
            return "Search TV"
        case .person:
            return "Search people"
        }
    }
    
    var icon: UIImage {
        switch self {
        case .movie:
            return UIImage(named: "movie_icon")!
        case .tv:
            return UIImage(named: "tv_icon")!
        case .person:
            return UIImage(systemName: "person.fill")!
        }
    }
}

enum ListType: String {
    case toWatch = "To Watch"
    case watched = "Watched"
    case favourite = "Favourites"
    
    var iconTintColor: UIColor {
        switch self {
        case .toWatch:
            return UIColor(named: "toWatchColor")!
        case .watched:
            return UIColor(named: "watchedColor")!
        case .favourite:
            return UIColor(named: "favouritesColor")!
        }
    }
    
    var iconName: String {
        switch self {
        case .toWatch:
            return "list.and.film"
        case .watched:
            return "checkmark"
        case .favourite:
            return "heart.fill"
        }
    }
}

enum ListAction: String {
    case add = "Add to"
    case move = "Move to"
    case remove = "Remove from"
    
    var icon: UIImage {
        switch self {
        case .add:
            return UIImage(systemName: "plus")!
        case .move:
            return UIImage(systemName: "arrow.left")!
        case .remove:
            return UIImage(systemName: "multiply")!
        }
    }
    
    var iconTintColor: UIColor {
        switch self {
        case .add:
            return .lightGray
        case .move:
            return .lightGray
        case .remove:
            return .red
        }
    }
}

enum ServiceURL {
    case movieGenreList
    case movieListByCategory(category: String, page: Int)
    case movieListByGenre(genreId: Int, page: Int)
    case movieDetail(movieId: Int)
    
    case tvGenreList
    case tvListByCategory(category: String, page: Int)
    case tvListByGenre(genreId: Int, page: Int)
    case tvDetail(tvId: Int)
    
    case castDetail(castId: Int)
    
    case search(searchType: SearchType, query: String, page: Int)
    
    var url: URL? {
        
        var urlString: String = ""
        
        switch self {
        case .movieGenreList:
            urlString = "/genre/movie/list\(Constants.constantUrlComponent)"
        case .movieListByCategory(let category, let page):
            urlString = "/movie/\(category)\(Constants.constantUrlComponent)&page=\(page)"
        case .movieListByGenre(let genreId, let page):
            urlString = "/discover/movie\(Constants.constantUrlComponent)&sort_by=popularity.desc&include_adult=false&include_video=false&page=\(page)&with_genres=\(genreId)"
        case .movieDetail(let movieId):
            urlString = "/movie/\(movieId)\(Constants.constantUrlComponent)&append_to_response=credits,recommendations,videos,watch/providers"
        case .tvGenreList:
            urlString = "/genre/tv/list\(Constants.constantUrlComponent)"
        case .tvListByCategory(let category, let page):
            urlString = "/tv/\(category)\(Constants.constantUrlComponent)&page=\(page)"
        case .tvListByGenre(let genreId, let page):
            urlString = "/discover/tv\(Constants.constantUrlComponent)&sort_by=popularity.desc&include_adult=false&include_video=false&page=\(page)&with_genres=\(genreId)"
        case .castDetail(let castId):
            urlString = "/person/\(castId)\(Constants.constantUrlComponent)&append_to_response=movie_credits,tv_credits,external_ids"
        case .tvDetail(let tvId):
            urlString = "/tv/\(tvId)\(Constants.constantUrlComponent)&append_to_response=aggregate_credits,recommendations,videos,watch/providers"
        case .search(let searchType, let query, let page):
            urlString = "/search/\(searchType.rawValue)\(Constants.constantUrlComponent)&query=\(query)&page=\(page)&include_adult=false"
            
        }

        return URL(string: Constants.baseURL + urlString)
    }
}

extension Constants {
    static let movieGenreImages = [28: "/5Zv5KmgZzdIvXz2KC3n0MyecSNL.jpg", 12: "/7WJjFviFBffEJvkAms4uWwbcVUk.jpg",
                                   16: "/wXsQvli6tWqja51pYxXNG1LFIGV.jpg", 35: "/3P52oz9HPQWxcwHOwxtyrVV1LKi.jpg",
                                   80: "/n6bUvigpRFqSwmPp1m2YADdbRBc.jpg", 99: "/yXq5MQqoJ7pw0nLK4IIDMl9VqbX.jpg",
                                   18: "/6VmFqApQRyZZzmiGOQq2C92jyvH.jpg", 10751: "/cJwkku3SPprS0Splfgh8VFRd0xn.jpg",
                                   14: "/bvRnPaai6JL7XHF4K6414DdSHro.jpg", 36: "/hjQp148VjWF4KjzhsD90OCMr11h.jpg",
                                   27: "/siBfSB55FBc7IdvgtApq6NaXNHw.jpg", 10402: "/gKZAQ3b9yApxFunUBlS5Mp74QG4.jpg",
                                   9648: "/8xt8AMb1OKC63AdhNSaYBWxB4Iq.jpg", 10749: "/oQaVV7p916HO5MDI820zzs1pin9.jpg",
                                   878: "/fNG7i7RqMErkcqhohV2a6cV1Ehy.jpg", 10770: "/bzeGOshNJgCRqrdDkSPR0HET5Wg.jpg",
                                   53: "/efrdAWS63s8TTWdrI2uNdIhn1dj.jpg", 10752: "/jqfCHNmjJVo5nJnLPM3ww7yqfNm.jpg",
                                   37: "/2oZklIzUbvZXXzIFzv7Hi68d6xf.jpg"]
    
    static let tvGenreImages = [10759: "/xVzvD5BPAU4HpleFSo8QOdHkndo.jpg", 16: "/A9sCKnxgTTapzu307ybdXCJQEqD.jpg",
                                35: "/l0qVZIpXtIo7km9u5Yqh0nKPOr5.jpg", 80: "/xGexTKCJDkl12dTW4YCBDXWb1AD.jpg",
                                99: "/ag2oZaayXrPL7XFEre5x4rBrxue.jpg", 18: "/qyDlF1U1yayXIUniECmGA1oBwZy.jpg",
                                10751: "/vLdBD1XSrhe8LzA09ouBBjhAa2L.jpg", 10762: "/gHoE5UByMIjbhBnbYxezrCVGwCL.jpg",
                                9648: "/qZtAf4Z1lazGQoYVXiHOrvLr5lI.jpg", 10763: "/uyilhJ7MBLjiaQXboaEwe44Z0jA.jpg",
                                10764: "/nRcPtIn39NEKCavn7S4wkO0WrwB.jpg", 10765: "/hTExot1sfn7dHZjGrk0Aiwpntxt.jpg",
                                10766: "/vIDHmF9U0gvQ1Oml9lV1LafHwqb.jpg", 10767: "/2Ib8kvWa9gGhJrAfGlhIvbmtbWn.jpg",
                                10768: "/8UVzqlBMG3azowsi7f8lqZwhcBZ.jpg", 37: "/yp94aOXzuqcQHva90B3jxLfnOO9.jpg"]
}
