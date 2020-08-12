//
//  AdvertTableViewCell.swift
//  RedditApp
//
//  Created by Petrov Anton on 07.08.2020.
//  Copyright © 2020 apm. All rights reserved.
//

import UIKit

class AdvertTableViewCell: UITableViewCell {
  
  // MARK: - IBOutlets
  
  @IBOutlet var cardView: UIView!
  
  @IBOutlet var authorView: UIView!
  @IBOutlet var thumbnailImageView: UIImageView!
  @IBOutlet var fullnameLabel: UILabel!
  
  @IBOutlet var titleView: UIView!
  @IBOutlet var titleLabel: UILabel!
  
  @IBOutlet var containerImageView: UIView!
  @IBOutlet var contentImageView: UIImageView!
  
  @IBOutlet var footerView: UIView!
  @IBOutlet var commentsLabel: UILabel!
  
  // MARK: - Private properties
  
  private var viewModel: AdvertViewModel?
  
  // MARK: - Life cycle
  
  override func awakeFromNib() {
    super.awakeFromNib()
    cardView.addShadow()
    clipsToBounds = true
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    thumbnailImageView.image = nil
    thumbnailImageView.cancelImageLoad()
    contentImageView.image = nil
    contentImageView.cancelImageLoad()
  }
  
  // MARK: - Private
  
  func updateCell(_ viewModel: AdvertViewModel) {
    titleLabel.text = viewModel.title
    fullnameLabel.text = viewModel.fullname
    commentsLabel.text = "\(viewModel.numberOfComments)"
    
    if let avatarURL = viewModel.avatarURL {
      thumbnailImageView.loadImage(at: avatarURL, completion: { })
    }
    
    if let contentImageURL = viewModel.contentImageURL {
      contentImageView.loadImage(at: contentImageURL, completion: { })
      containerImageView.isHidden = false
    } else {
      containerImageView.isHidden = true
    }
    
  }
  
  // MARK: - Public
  
  func setupViewModel(_ viewModel: AdvertViewModel) {
    self.viewModel = viewModel
    updateCell(viewModel)
  }
  
}
