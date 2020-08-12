//
//  PreviewImageViewController.swift
//  RedditApp
//
//  Created by Petrov Anton on 12.08.2020.
//  Copyright © 2020 apm. All rights reserved.
//

import UIKit

class PreviewImageViewController: UIViewController {
  
  // MARK: - IBOutlets
  
  @IBOutlet var imageView: UIImageView!
  @IBOutlet var saveButton: UIBarButtonItem!
  @IBOutlet var activityView: UIActivityIndicatorView!
  
  var viewModel: PreviewImageViewModel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    bind()
  }
  
  private func bind() {
    viewModel.isActivityLoading.observe(on: self) { [weak self] isLoading in
      guard let `self` = self else { return }
      self.setActivityViewLoading(isLoading)
    }
    
    viewModel.alertInfo.observe(on: self) { [weak self] info in
      self?.showAlert(title: info.title, message: info.message)
    }
    
    saveButton.isEnabled = false
    self.setActivityViewLoading(true)
    imageView.loadImage(at: viewModel.previewImageURL, completion: { [weak self] in
      self?.saveButton.isEnabled = true
      self?.setActivityViewLoading(false)
    })
    
  }
  
  // MARK: - Actions
  
  @IBAction func actionSave(_ sender: UIBarButtonItem) {
    guard let image = imageView.image else {
      showAlert(title: "Save error!", message: "Image not loaded")
      return
    }
    viewModel.saveImage(image: image)
  }
  
  func setActivityViewLoading(_ isLoading: Bool) {
    guard activityView.isAnimating != isLoading else { return }
    isLoading ? activityView.startAnimating() : activityView.stopAnimating()
  }
  
}
