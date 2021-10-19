//
//  TabBarViewController.swift
//  Mowie
//
//  Created by Turan Yilmaz on 10.04.2021.
//

import UIKit

final class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let pageVCForMovie = createPageViewController(for: .movie)
        let pageVCForTV = createPageViewController(for: .tv)
        
        let searchStoryboard = UIStoryboard(name: "Search", bundle: Bundle.main)
        let searchVC = searchStoryboard.instantiateViewController(identifier: "NavigationViewController") as! UINavigationController
        
        let listsStoryboard = UIStoryboard(name: "Lists", bundle: Bundle.main)
        let listsVC = listsStoryboard.instantiateViewController(identifier: "NavigationViewController") as! UINavigationController
        
        let aboutVC = AboutViewController.instantiateFromStoryboard()
        
        // Tab bar item ui
        pageVCForMovie.tabBarItem = UITabBarItem(title: ItemType.movie.rawValue,
                                                 image: UIImage(named: "movie_icon"),
                                                 selectedImage: nil)
        
        pageVCForTV.tabBarItem = UITabBarItem(title: ItemType.tv.rawValue,
                                              image: UIImage(named: "tv_icon"),
                                              selectedImage: nil)
        
        listsVC.tabBarItem = UITabBarItem(title: "Lists",
                                          image: UIImage(systemName: "list.bullet"),
                                          selectedImage: nil)
        
        searchVC.tabBarItem = UITabBarItem(title: "Search",
                                           image: UIImage(systemName: "magnifyingglass"),
                                           selectedImage: nil)
        
        aboutVC.tabBarItem = UITabBarItem(title: "About",
                                          image: UIImage(systemName: "info.circle"),
                                          selectedImage: nil)
        
        
//        tabBar.backgroundImage = UIImage(color: UIColor(red: 0, green: 0, blue: 0, alpha: 0.5))
        
        
        tabBar.barTintColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        tabBar.isTranslucent = false
        tabBar.tintColor = UIColor(named: "mainOrange")
        
        viewControllers = [pageVCForMovie, pageVCForTV, listsVC, searchVC, aboutVC]
        
    }
    
    private func createPageViewController(for type: ItemType) -> UINavigationController {
        let storyboard = UIStoryboard(name: "PageView", bundle: Bundle.main)
        let navigationVC = storyboard.instantiateViewController(identifier: "NavigationViewController") as! UINavigationController
        let pageVC = navigationVC.viewControllers.first as! PageViewController
        pageVC.dataModel = Utility.createPages(for: type)
        
        return navigationVC
    }
}


//public extension UIImage {
//      public convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
//          let rect = CGRect(origin: .zero, size: size)
//          UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
//          color.setFill()
//          UIRectFill(rect)
//          let image = UIGraphicsGetImageFromCurrentImageContext()
//          UIGraphicsEndImageContext()
//
//        guard let cgImage = image?.cgImage else { return nil }
//          self.init(cgImage: cgImage)
//      }
//  }
