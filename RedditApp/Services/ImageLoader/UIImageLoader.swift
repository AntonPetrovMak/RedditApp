//
//  UIImageLoader.swift
//  RedditApp
//
//  Created by Petrov Anton on 11.08.2020.
//  Copyright © 2020 apm. All rights reserved.
//

import UIKit

final class UIImageLoader {
  
  static let loader = UIImageLoader()
  
  private let imageLoader = ImageLoader()
  private var uuidMap = [UIImageView: UUID]()
  
  private init() {}
  
  func load(_ url: URL, for imageView: UIImageView) {
    let token = imageLoader.loadImage(url) { result in
      result.mapSuccess { data in
        DispatchQueue.main.async {
          imageView.image = UIImage(data: data)
        }
      }
      
      self.uuidMap.removeValue(forKey: imageView)
    }
    
    guard let _token = token else { return }
    uuidMap[imageView] = _token
  }
  
  func cancel(for imageView: UIImageView) {
    guard let uuid = uuidMap[imageView] else { return }
    imageLoader.cancelLoad(uuid)
    uuidMap.removeValue(forKey: imageView)
  }
}
