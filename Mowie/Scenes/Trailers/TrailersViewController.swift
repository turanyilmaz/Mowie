//
//  TrailersViewController.swift
//  Mowie
//
//  Created by Turan Yilmaz on 23.08.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit
import youtube_ios_player_helper

protocol TrailersDisplayLogic: AnyObject {
    func displayTrailer(videoId: String)
}

final class TrailersViewController: UIViewController, TrailersDisplayLogic {
    var interactor: TrailersBusinessLogic?
    var router: (NSObjectProtocol & TrailersRoutingLogic & TrailersDataPassing)?
    
    @IBOutlet weak var playerView: YTPlayerView!
    
    var firstCenter: CGPoint = .zero
    
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
        let interactor = TrailersInteractor()
        let presenter = TrailersPresenter()
        let router = TrailersRouter()
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
        
        playerView.delegate = self
        
        playerView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(movePlayerView(_:))))
        
        interactor?.getTrailer()
    }
    
    @IBAction func viewTapped(_ sender: UITapGestureRecognizer) {
        dismiss(animated: false, completion: nil)
    }
    
    @objc
    func movePlayerView(_ gestureRecognizer : UIPanGestureRecognizer) {
        
        if gestureRecognizer.state == .began {
            firstCenter = gestureRecognizer.view!.center
        }
        
        if gestureRecognizer.state == .changed {
            let point = gestureRecognizer.translation(in: view)
            gestureRecognizer.view?.center = CGPoint(x: firstCenter.x + point.x, y: firstCenter.y + point.y)
        }
        
        if gestureRecognizer.state == .ended {
            let point = gestureRecognizer.translation(in: view)
            if point.y > 20.0 {
                dismiss(animated: false, completion: nil)
            } else {
                UIView.animate(withDuration: 0.3) {
                    gestureRecognizer.view?.center = self.firstCenter
                    
                }
            }
        }
    }
    
    // MARK: Display Logic
    
    func displayTrailer(videoId: String) {
        playerView.load(withVideoId: videoId, playerVars: ["playsinline": 1])
    }
}

extension TrailersViewController: YTPlayerViewDelegate {
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        playerView.playVideo()
    }
}

extension TrailersViewController: Instantiable {
    static var storyboardName: String {
        return "Trailers"
    }
}