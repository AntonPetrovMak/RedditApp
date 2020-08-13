//
//  ListingsWorker.swift
//  RedditApp
//
//  Created by Petrov Anton on 10.08.2020.
//  Copyright © 2020 apm. All rights reserved.
//

import Foundation

protocol ListingsWorker {
  func fetchFirstPosts(completion: @escaping (Result<[Post], Error>) -> Void)
  func fetchMorePosts(completion: @escaping (Result<[Post], Error>) -> Void)
}

// NOTE: here can cashed listings as you wish using NSUserDefault or any database
final class RedditListingsWorker: ListingsWorker {
  
  private let store: ListingsStore
  private let count: UInt
  private let limit: UInt
  private var listings = [Listing]()
  
  init(store: ListingsStore, count: UInt = 0, limit: UInt = 20) {
    self.store = store
    self.count = count
    self.limit = limit
  }
  
  func clearListings() {
    listings = [Listing]()
  }
  
  func fetchFirstPosts(completion: @escaping (Result<[Post], Error>) -> Void) {
    clearListings()
    fetchPosts { [weak self] result in
      guard let `self` = self else { return }
      switch result {
      case .success(let model):
        self.listings = [model]
        completion(.success(model.posts))
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }
  
  func fetchMorePosts(completion: @escaping (Result<[Post], Error>) -> Void) {
    guard let lastPostId = listings.last?.after else {
      fetchFirstPosts(completion: completion)
      return
    }
    
    fetchPosts(after: lastPostId) { [weak self] result in
      guard let `self` = self else { return }
      switch result {
      case .success(let model):
        self.listings += [model]
        completion(.success(model.posts))
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }
  
  private func fetchPosts(after: String? = nil, before: String? = nil, completion: @escaping (Result<Listing, Error>) -> Void) {
    store.fetchPosts(count: count, limit: limit, after: after, before: before, completion: completion)
  }
}
