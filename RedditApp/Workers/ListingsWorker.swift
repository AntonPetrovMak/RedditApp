//
//  ListingsWorker.swift
//  RedditApp
//
//  Created by Petrov Anton on 10.08.2020.
//  Copyright © 2020 apm. All rights reserved.
//

import Foundation

protocol ListingsWorker {
  func loadTopListings(completion: @escaping (Result<Listing, Error>) -> Void)
}

class RedditListingsWorker: ListingsWorker {
  
  private let store: ListingsStore
  
  init(store: ListingsStore) {
    self.store = store
  }
  
  func loadTopListings(completion: @escaping (Result<Listing, Error>) -> Void) {
    store.loadTopListings(completion: completion)
  }
  
}
