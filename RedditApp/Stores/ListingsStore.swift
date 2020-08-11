//
//  ListingsStore.swift
//  RedditApp
//
//  Created by Petrov Anton on 11.08.2020.
//  Copyright © 2020 apm. All rights reserved.
//

import Foundation

protocol ListingsStore {
  func loadTopListings<T: Decodable>(completion: @escaping (Result<T, Error>) -> Void)
}

class RedditListingsStore: ListingsStore {
  
  func loadTopListings<T: Decodable>(completion: @escaping (Result<T, Error>) -> Void) {
    let endpoint = RedditListingsRouter.top
    RESTClient.performRequestWithDecodableModel(endpoint: endpoint, completion: completion)
  }
  
}
