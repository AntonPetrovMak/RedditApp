//
//  UIImageView+ImageLoading.swift
//  RedditApp
//
//  Created by Petrov Anton on 11.08.2020.
//  Copyright © 2020 apm. All rights reserved.
//

import UIKit

extension UIImageView {
  func loadImage(at url: URL) {
    UIImageLoader.loader.load(url, for: self)
  }
  
  func cancelImageLoad() {
    UIImageLoader.loader.cancel(for: self)
  }
}
