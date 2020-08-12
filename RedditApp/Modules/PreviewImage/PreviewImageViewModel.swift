//
//  PreviewImageViewModel.swift
//  RedditApp
//
//  Created by Petrov Anton on 12.08.2020.
//  Copyright © 2020 apm. All rights reserved.
//

import UIKit

protocol PreviewImageViewModel {
  var previewImageURL: URL { get }
  var isActivityLoading: Observable<Bool> { get }
  var alertInfo: Observable<(title: String, message: String)> { get }
  
  func saveImage(image: UIImage)
}

final class RedditPreviewImageViewModel: NSObject, PreviewImageViewModel {
  
  // MARK: PreviewImageViewModel
  
  var previewImageURL: URL
  var isActivityLoading = Observable(false)
  var alertInfo = Observable((title: "", message: ""))
  
  func saveImage(image: UIImage) {
    saveImageToAlbum(image: image)
  }
  
  // MARK: Init
  
  init(previewImageURL: URL) {
    self.previewImageURL = previewImageURL
  }
  
  // MARK: - Image Saving Helpers
  
  
  
  func saveImageToAlbum(image: UIImage) {
    UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
  }
  
  @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
    if let error = error {
      alertInfo.value = (title: "Save error", message: error.localizedDescription)
    } else {
      alertInfo.value = (title: "Saved!", message: "Your altered image has been saved to your photos")
    }
  }

}
