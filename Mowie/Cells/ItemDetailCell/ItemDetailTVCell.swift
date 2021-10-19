//
//  ItemDetailCVCell.swift
//  Mowie
//
//  Created by Turan Yilmaz on 13.04.2021.
//

import UIKit

final class ItemDetailTVCell: UITableViewCell, ListViewCellProtocol {
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var releaseYearLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var rateView: UIView!
    @IBOutlet weak var backdropImageView: UIImageView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var playTrailerStackView1: UIStackView!
    @IBOutlet weak var playTrailerStackView2: UIStackView!
    @IBOutlet weak var selectedListIconContainer: UIView!
    @IBOutlet weak var selectedListIconImageView: UIImageView!
    var trailerButtonTappedCallback: (() -> Void)?
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        backdropImageView?.roundCorners(corners: [.topLeft, .topRight],
                                       radius: 16)
        
        containerView.roundCorners(corners: [.topLeft, .topRight],
                                       radius: 2)
        
        rateView.layer.cornerRadius = rateView.frame.height / 2
        rateView.layer.borderWidth = 1
        rateView.layer.borderColor = UIColor(named: "mainOrange")?.cgColor
    }
    
    func configure(with viewModel: ListViewModelProtocol) {
        guard let viewModel = viewModel as? ItemDetailTVCellModel else {
            return
        }
        
        posterImageView.sd_setImage(with: viewModel.posterImageUrl, placeholderImage: UIImage(named: "poster_placeholder"))
        
        titleLabel.text = viewModel.title
        rateLabel.text = viewModel.voteAverage
        releaseYearLabel.text = viewModel.releaseDate.defaultEmptyValue
        durationLabel.text = viewModel.runtime.defaultEmptyValue
        genresLabel.text = viewModel.genres.defaultEmptyValue
        countryLabel.text = viewModel.language.defaultEmptyValue
        
        if viewModel.backdropImageUrl == nil {
            backdropImageView?.removeFromSuperview()
            
            playTrailerStackView1.isHidden = true
            playTrailerStackView2.isHidden = viewModel.hidePlayTrailerButton
        } else {
            backdropImageView?.sd_setImage(with: viewModel.backdropImageUrl)
            
            playTrailerStackView1.isHidden = viewModel.hidePlayTrailerButton
            playTrailerStackView2.isHidden = true
        }
        
        trailerButtonTappedCallback = viewModel.trailerButtonTappedCallback
    }
    
    @IBAction func playButtonTapped(_ sender: UIButton) {
        trailerButtonTappedCallback?()
    }
    
    @objc
    func listDidSelect(notification: Notification) {
        if let selectedList = notification.userInfo?["selectedList"] as? ListType {
            selectedListIconImageView.tintColor = selectedList.iconTintColor
            selectedListIconImageView.image = UIImage(systemName: selectedList.iconName)
            selectedListIconContainer.isHidden = false
        }
    }
}
