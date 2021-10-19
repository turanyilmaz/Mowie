//
//  AboutViewController.swift
//  Mowie
//
//  Created by Turan Yilmaz on 28.09.2021.
//

import UIKit

final class AboutViewController: UIViewController {

    @IBOutlet weak var tmdbStackView: UIStackView!
    @IBOutlet weak var icons8StackView: UIStackView!
    @IBOutlet weak var appVersionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        appVersionLabel.text = Utility.getAppVersion()
        
        let tapGesture1 = UITapGestureRecognizer(target: self, action: #selector(stackViewTapped(_:)))
        let tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(stackViewTapped(_:)))
    
        tmdbStackView.addGestureRecognizer(tapGesture1)
        icons8StackView.addGestureRecognizer(tapGesture2)
    }
    
    @objc
    func stackViewTapped(_ sender: UITapGestureRecognizer) {
        
        switch sender.view?.tag {
        case 101:
            UIApplication.shared.open(URL(string: "https://developers.themoviedb.org/3")!)
        case 102:
            UIApplication.shared.open(URL(string: "https://icons8.com")!)
        default:
            return
        }
    }
}

extension AboutViewController: Instantiable {
    static var storyboardName: String {
        return "About"
    }
}
