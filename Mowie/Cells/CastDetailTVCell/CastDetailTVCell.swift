//
//  CastDetailTVCell.swift
//  Mowie
//
//  Created by Turan Yilmaz on 22.04.2021.
//

import UIKit

final class CastDetailTVCell: UITableViewCell, ListViewCellProtocol {
    @IBOutlet weak var castImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var birthDateLabel: UILabel!
    @IBOutlet weak var homeTownLabel: UILabel!
    @IBOutlet weak var moviesCountLabel: UILabel!
    @IBOutlet weak var tvsCountLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet var socialMediaButtons: [UIButton]!
    @IBOutlet weak var socialMediaButtonStackView: UIStackView!
    
    var externalIds: ExternalIDS?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        castImageView.layer.cornerRadius = castImageView.frame.size.height / 2
        castImageView.layer.borderWidth = 1
        castImageView.layer.borderColor = UIColor.black.cgColor
    }
    
    
    
    func configure(with viewModel: ListViewModelProtocol) {
        guard let viewModel = viewModel as? CastDetailTVCellModel else {
            return
        }
        
        bgImageView.sd_setImage(with: viewModel.imageURL)
        castImageView.sd_setImage(with: viewModel.imageURL,
                                  placeholderImage: UIImage(systemName: "person.fill"))
        nameLabel.text = viewModel.name
        birthDateLabel.text = viewModel.birthDate
        homeTownLabel.text = viewModel.homeTown
        moviesCountLabel.text = viewModel.moviesCount
        tvsCountLabel.text = viewModel.tvsCount
        
        // Social Media Buttons
        externalIds = viewModel.externalIds
        
        if let externalIds = viewModel.externalIds {
            prepareSocialMediaButtons(ids: externalIds)
        } else {
            socialMediaButtonStackView.isHidden = true
        }
    }
    
    private func prepareSocialMediaButtons(ids: ExternalIDS) {
        
        if let instagramID = ids.instagramID, !instagramID.isEmpty {
            let button = createSocialMediaButton(for: .instagram)
            socialMediaButtonStackView.addArrangedSubview(button)
        }
        
        if let twitterID = ids.twitterID, !twitterID.isEmpty {
            let button = createSocialMediaButton(for: .twitter)
            socialMediaButtonStackView.addArrangedSubview(button)
        }
        
        if let facebookID = ids.facebookID, !facebookID.isEmpty {
            let button = createSocialMediaButton(for: .facebook)
            socialMediaButtonStackView.addArrangedSubview(button)
        }
        
        if let imdbID = ids.imdbID, !imdbID.isEmpty {
            let button = createSocialMediaButton(for: .imdb)
            socialMediaButtonStackView.addArrangedSubview(button)
        }
    }
    
    private func createSocialMediaButton(for socialMedia: SocialMedia) -> UIButton {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 32, height: 32))
        button.setImage(socialMedia.icon, for: .normal)
        button.tag = socialMedia.rawValue
        button.addTarget(self,
                         action: #selector(socialMediaButtonTapped(_:)),
                         for: .touchUpInside)
        
        button.heightAnchor.constraint(equalToConstant: 32).isActive = true
        button.widthAnchor.constraint(equalToConstant: 32).isActive = true
        
        return button
    }
    
    @objc
    func socialMediaButtonTapped(_ sender: UIButton) {
        
        guard let socialMediaLinks = externalIds,
              let socialMedia = SocialMedia(rawValue: sender.tag) else {
            return
        }
        
        
        if let url = socialMedia.getUrl(by: socialMediaLinks) {
            UIApplication.shared.open(url)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        socialMediaButtonStackView.arrangedSubviews.forEach { view in
            socialMediaButtonStackView.removeArrangedSubview(view)
            view.removeFromSuperview()
        }
        
    }
}
