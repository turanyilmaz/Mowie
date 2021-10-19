//
//  TrailerTableViewCell.swift
//  Mowie
//
//  Created by Turan Yilmaz on 23.08.2021.
//

import UIKit
import youtube_ios_player_helper

final class TrailerTableViewCell: UITableViewCell, ListViewCellProtocol {
    
    @IBOutlet weak var ytPlayerView: YTPlayerView!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var isLoaded = false
    
    func configure(with viewModel: ListViewModelProtocol) {
        guard let viewModel = viewModel as? TrailerTableViewCellModel else {
            return
        }
        
        titleLabel.text = viewModel.title
        
        let url = URL(string: "https://i.ytimg.com/vi/\(viewModel.videoId)/hqdefault.jpg")
        
        thumbnailImageView.sd_setImage(with: url)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(thumbnailTapped))
        thumbnailImageView.addGestureRecognizer(tapGesture)
        
        isLoaded = ytPlayerView.load(withVideoId: viewModel.videoId)
    }
    
    @objc
    func thumbnailTapped() {
        ytPlayerView.playVideo()
    }
    
}
