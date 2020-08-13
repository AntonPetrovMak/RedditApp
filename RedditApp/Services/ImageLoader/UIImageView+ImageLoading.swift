//
//  UIImageView+ImageLoading.swift
//  RedditApp
//
//  Created by Petrov Anton on 11.08.2020.
//  Copyright © 2020 apm. All rights reserved.
//

import UIKit

extension UIImageView {
  
  func loadImage(at url: URL, completion: @escaping () -> Void) {
    UIImageLoader.loader.load(url, for: self, completion: completion)
  }
  
  func cancelImageLoad() {
    UIImageLoader.loader.cancel(for: self)
  }
  
}
