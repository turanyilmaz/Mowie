//
//  PageViewController.swift
//  Mowie
//
//  Created by Turan Yilmaz on 9.04.2021.
//

import UIKit
import Tabman
import Pageboy

class PageViewController: TabmanViewController {
    
    var dataModel: (viewControllers: [UIViewController], titles: [String])?
//    var pageType: ItemType = .movie
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.dataSource = self
        
        // Navigation back button
        let backItem = UIBarButtonItem(title: nil)
        backItem.tintColor = UIColor(named: "mainOrange")
        self.navigationItem.backBarButtonItem = backItem
        navigationController?.navigationBar.overrideUserInterfaceStyle = .light
        
        // Create bar
        let bar = TMBar.ButtonBar()
        bar.layout.transitionStyle = .snap // Customize
        bar.layout.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
        bar.layout.alignment = .centerDistributed
        
        bar.indicator.tintColor = UIColor(named: "mainOrange")
        bar.indicator.cornerStyle = .eliptical
        
        bar.backgroundView.style = .flat(color: .black)
        bar.buttons.customize { (button) in
            button.tintColor = UIColor.white.withAlphaComponent(0.5)
            button.selectedTintColor = .white
            button.font = UIFont(name: "Avenir", size: 15)!
        }
        
        // Add to view
        addBar(bar, dataSource: self, at: .top)
    }
}

extension PageViewController: PageboyViewControllerDataSource, TMBarDataSource {

    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return (dataModel?.viewControllers.count).intValue
    }

    func viewController(for pageboyViewController: PageboyViewController,
                        at index: PageboyViewController.PageIndex) -> UIViewController? {
        
        return dataModel?.viewControllers[index]
    }

    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return nil
    }

    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        let title = (dataModel?.titles[index]).stringValue
        return TMBarItem(title: title)
    }
}

extension PageViewController: Instantiable {
    static var storyboardName: String {
        return "PageView"
    }
}


