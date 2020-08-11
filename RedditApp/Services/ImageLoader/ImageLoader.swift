//
//  ImageLoader.swift
//  RedditApp
//
//  Created by Petrov Anton on 11.08.2020.
//  Copyright © 2020 apm. All rights reserved.
//

import Foundation

final class ImageLoader {
  
  private var loadedImages = [URL: Data]()
  private var runningRequests = [UUID: URLSessionDataTask]()
  
  func loadImage(_ url: URL, _ completion: @escaping (Result<Data, Error>) -> Void) -> UUID? {
    if let image = loadedImages[url] {
      completion(.success(image))
      return nil
    }
    
    let uuid = UUID()
    
    let task = RESTClient.loadImage(url: url) { result in
      defer { self.runningRequests.removeValue(forKey: uuid) }
      switch result {
      case .success(let data):
        self.loadedImages[url] = data
        completion(.success(data))
      case .failure(let error):
        guard (error as NSError).code == NSURLErrorCancelled else {
          completion(.failure(error))
          return
        }
      }
    }
    
    task.resume()
    
    runningRequests[uuid] = task
    return uuid
  }
  
  func cancelLoad(_ uuid: UUID) {
    runningRequests[uuid]?.cancel()
    runningRequests.removeValue(forKey: uuid)
  }
  
}
