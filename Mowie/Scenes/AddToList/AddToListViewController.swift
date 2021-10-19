//
//  AddToListViewController.swift
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

protocol AddToListDisplayLogic: AnyObject {
    func displayOptions(viewModel: AddToList.ViewModel)
    func displaySavedItemState(for list: ListType, action: ListAction)
}

final class AddToListViewController: UIViewController, AddToListDisplayLogic {
    var interactor: AddToListBusinessLogic?
    var router: (NSObjectProtocol & AddToListRoutingLogic & AddToListDataPassing)?
    
    @IBOutlet weak var drawerView: UIView!
    @IBOutlet weak var drawerLineView: UIView!
    @IBOutlet weak var backdropImageView: UIImageView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var itemNameLabel: UILabel!
    
    @IBOutlet weak var visualEffect: UIVisualEffectView!
    @IBOutlet var listOptionViews: [ListOptionView]!
    
    @IBOutlet weak var drawerTitleLabel: UILabel!
    @IBOutlet weak var selectedListImageView: UIImageView!
    
    let drawerAnimationDuration: TimeInterval = 0.2
    let selectedListAnimationDuration: TimeInterval = 0.5
    let selectedListAnimationDelay: TimeInterval = 0.3
    
    
    weak var shapeLayer: CAShapeLayer?
    
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
        let interactor = AddToListInteractor()
        let presenter = AddToListPresenter()
        let router = AddToListRouter()
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
        
        setupViews()
        
        interactor?.showOptions()
        
        drawerView.layoutIfNeeded()
        drawerView.roundCorners(corners: [.topLeft, .topRight],
                                radius: 14)

        drawerLineView.layer.cornerRadius = drawerLineView.frame.height/2
        
        self.drawerView.transform = CGAffineTransform(translationX: 0, y: self.drawerView.frame.height)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        showDrawer()
    }
    
    private func setupViews() {
        listOptionViews.forEach { view in
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(listDidSelect(recognizer:)))
            view.addGestureRecognizer(tapGesture)
        }
    }
    
    @objc
    private func listDidSelect(recognizer: UITapGestureRecognizer) {
        guard let listOptionView = recognizer.view as? ListOptionView,
              let listType = listOptionView.viewModel?.list, let action = listOptionView.viewModel?.action else {
            return
        }
        
//        interactor?.saveItem(to: listType)
        interactor?.databaseAction(list: listType, action: action)
    }
    
    private func showDrawer() {
        UIView.animate(withDuration: drawerAnimationDuration) {
            self.drawerView.transform = CGAffineTransform.identity
            self.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.75)
            self.view.layoutIfNeeded()
        }
    }
    
    private func removeAnimation(completion: ((Bool) -> Void)?) {
        let statusBarHeight = UIApplication.shared.keyWindow?.windowScene?.statusBarManager?.statusBarFrame.height
        
        self.selectedListImageView.center = CGPoint(x: self.view.frame.width - 32,
                                              y: statusBarHeight! + 22)
        
        self.selectedListImageView.transform = CGAffineTransform(scaleX: 0.3, y: 0.3)
        
        self.selectedListImageView.isHidden = false
        
        UIView.animate(withDuration: selectedListAnimationDuration, delay: selectedListAnimationDelay, animations: {
            self.selectedListImageView.transform = CGAffineTransform(scaleX: 1, y: 1)
            self.selectedListImageView.center = self.view.center
        }, completion: { _ in
            
            
            
            self.drawLine(startX: Int(self.selectedListImageView.frame.width - 20),
                          toEndingX: 20,
                          startingY: 0,
                          toEndingY: Int(self.selectedListImageView.frame.height),
                          ofColor: .white,
                          widthOfLine: 3,
                          inView: self.selectedListImageView)
            
            
            UIView.animate(withDuration: 0.3, delay: 0.6) {
                self.view.backgroundColor = .clear
                self.selectedListImageView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            } completion: { _ in
                completion?(true)
            }

            
            
            
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
//                completion?(true)
//            }
        })
    }
    
    private func addAnimation(completion: ((Bool) -> Void)?) {
        self.selectedListImageView.isHidden = false
        
        UIView.animate(withDuration: selectedListAnimationDuration, delay: selectedListAnimationDelay, animations: {
            self.selectedListImageView.transform = CGAffineTransform(scaleX: 0.3, y: 0.3)
            
            let statusBarHeight = UIApplication.shared.keyWindow?.windowScene?.statusBarManager?.statusBarFrame.height
            
            self.selectedListImageView.center = CGPoint(x: self.view.frame.width - 32,
                                                  y: statusBarHeight! + 22)
            
            self.view.backgroundColor = .clear
        }, completion: completion)
    }
    
    private func hideDrawerAnimation(isListSelected: Bool = false,
                                     completion: ((Bool) -> Void)? = nil,
                                     action: ListAction? = nil) {
        
        UIView.animate(withDuration: drawerAnimationDuration, animations: {
            if !isListSelected {
                self.view.backgroundColor = .clear
            }
            self.drawerView.transform = CGAffineTransform(translationX: 0, y: self.drawerView.frame.height)
            self.view.layoutIfNeeded()
        }, completion: { _ in
            
            guard isListSelected else {
                self.router?.routeToBack()
                return
            }
            
            if action == .remove {
                self.removeAnimation(completion: completion)
            } else {
                self.addAnimation(completion: completion)
            }
        })
    }
    
    @IBAction func viewTapped(_ sender: UITapGestureRecognizer) {
        hideDrawerAnimation()
    }
    
    @IBAction func drawerViewDidDrag(_ sender: UIPanGestureRecognizer) {
        
        let point = sender.translation(in: drawerView)
        
        guard point.y > 0 else {
            return
        }
        
        self.drawerView.transform = CGAffineTransform(translationX: 0, y: point.y)
        
        if sender.state == .ended {
            if point.y < 60 {
                showDrawer()
            } else {
                hideDrawerAnimation()
            }
        }
    }
    
    // MARK: Display Logic
    
    func displayOptions(viewModel: AddToList.ViewModel) {
        
        for (index, optionView) in listOptionViews.enumerated() {
            optionView.viewModel = viewModel.viewModel[index]
        }
        
        drawerTitleLabel.text = viewModel.drawerTitle
        
        backdropImageView.sd_setImage(with: viewModel.posterImageUrl)
        posterImageView.sd_setImage(with: viewModel.posterImageUrl,
                                    placeholderImage: UIImage(named: "poster_placeholder"))
        
        itemNameLabel.text = viewModel.itemName
    }
    
    func displaySavedItemState(for list: ListType, action: ListAction) {
        
        selectedListImageView.image = UIImage(systemName: list.iconName)
        selectedListImageView.tintColor = list.iconTintColor
        
        hideDrawerAnimation(isListSelected: true, completion: { _ in
            
            self.router?.routeToBack()
            NotificationCenter.default.post(name: Notification.Name("listSelected"),
                                            object: nil,
                                            userInfo: ["selectedList" : list, "action" : action])
        }, action: action)
    }
    
    func drawLine(startX: Int,
                  toEndingX endX: Int,
                  startingY startY: Int,
                  toEndingY endY: Int,
                  ofColor lineColor: UIColor,
                  widthOfLine lineWidth: CGFloat,
                  inView view: UIView) {
        
        self.shapeLayer?.removeFromSuperlayer()

        let path = UIBezierPath()
        path.move(to: CGPoint(x: startX, y: startY))
        path.addLine(to: CGPoint(x: endX, y: endY))

        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = lineColor.cgColor
        shapeLayer.cornerRadius = 2
        shapeLayer.lineWidth = lineWidth

        view.layer.addSublayer(shapeLayer)
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.duration = 0.3
        shapeLayer.add(animation, forKey: "MyAnimation")
        
        self.shapeLayer = shapeLayer

    }
}

extension AddToListViewController: Instantiable {
    static var storyboardName: String {
        return "AddToList"
    }
}
