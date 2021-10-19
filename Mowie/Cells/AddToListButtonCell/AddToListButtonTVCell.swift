//
//  AddToListTVCell.swift
//  Mowie
//
//  Created by Turan Yilmaz on 13.04.2021.
//

import UIKit
import WebKit

final class AddToListButtonTVCell: UITableViewCell, ListViewCellProtocol {
    
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var watchButton: UIButton!
    
    var addButtonTappedCallback: (() -> Void)?
    var watchButtonTappedCallback: (() -> Void)?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        addButton.layer.cornerRadius = addButton.frame.height / 2
//        addButton.layer.borderWidth = 1
//        addButton.layer.borderColor = UIColor(named: "mainOrange")?.cgColor
        
        watchButton.layer.cornerRadius = watchButton.frame.height / 2
    }
    
    func configure(with viewModel: ListViewModelProtocol) {
        guard let viewModel = viewModel as? AddToListButtonTVCellModel else {
            return
        }
        
        addButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
        watchButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
        
        addButtonTappedCallback = viewModel.addButtonTappedCallback
        addButton.setTitle(viewModel.title, for: .normal)
        
        watchButtonTappedCallback = viewModel.watchButtonTappedCallback
    }
    
    @IBAction func addButtonTapped(_ sender: UIButton) {
        addButtonTappedCallback?()
    }
    
    @IBAction func watchButtonTapped(_ sender: UIButton) {
        watchButtonTappedCallback?()
    }
}
