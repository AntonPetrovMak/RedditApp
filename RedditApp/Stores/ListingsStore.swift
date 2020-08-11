//
//  ListingsStore.swift
//  RedditApp
//
//  Created by Petrov Anton on 11.08.2020.
//  Copyright © 2020 apm. All rights reserved.
//

import Foundation

protocol ListingsStore {
  func fetchPosts<T: Decodable>(count: UInt, limit: UInt, after: String?, before: String?, completion: @escaping (Result<T, Error>) -> Void)
}

class RedditListingsStore: ListingsStore {
  
  func fetchPosts<T: Decodable>(count: UInt, limit: UInt, after: String?, before: String?, completion: @escaping (Result<T, Error>) -> Void) {
    let requestData = RedditListingsRouter.TopListingsData(count: count,
                                                           limit: limit,
                                                           after: after,
                                                           before: before)
    let endpoint = RedditListingsRouter.top(data: requestData)
    RESTClient.performRequestWithDecodableModel(endpoint: endpoint, completion: completion)
  }
  
}
