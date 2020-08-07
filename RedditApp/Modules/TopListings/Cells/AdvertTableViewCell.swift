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
  
  @IBOutlet var imagesView: UIView!
  @IBOutlet var imagesStackView: UIStackView!
  
  @IBOutlet var footerView: UIView!
  @IBOutlet var commentsLabel: UILabel!
  
  private(set) var viewModel: AdvertViewModel?
  
  override func awakeFromNib() {
    super.awakeFromNib()
    cardView.layer.cornerRadius = 5
    cardView.addShadow()
  }
  
  // MARK: - Private
  
  func updateCell(_ viewModel: AdvertViewModel) {
    titleLabel.text = viewModel.title
    fullnameLabel.text = viewModel.fullname
  }
  
  // MARK: - Public
  
  func setupViewModel(_ viewModel: AdvertViewModel) {
    self.viewModel = viewModel
    updateCell(viewModel)
  }
  
}
