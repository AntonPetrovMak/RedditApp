//
//  RedditTopListingsViewModel.swift
//  RedditApp
//
//  Created by Petrov Anton on 11.08.2020.
//  Copyright © 2020 apm. All rights reserved.
//

import Foundation

final class RedditTopListingsViewModel: TopListingsViewModel {
  
  // MARK: - TopListingsViewModel
  
  var sections: [TopListingsSection] {
    return redditSections
  }
  
  var reload = ObservableEmpty()
  var isActivityLoading = Observable(false)
  var isRefreshLoading = Observable(false)
  var errorAlertMessage = Observable("")
  
  func doLaunch() {
    fetchFirstPosts(loadingIndicator: isActivityLoading)
  }
  
  func refreshSections() {
    fetchFirstPosts(loadingIndicator: isRefreshLoading)
  }
  
  func loadMoreSections() {
    fetchMorePosts(loadingIndicator: isActivityLoading)
  }

  // MARK: - Private properties
  
  private var posts = [Post]() {
    didSet {
      redditTopListings = posts.map { viewModelsFactory.makeAdvertViewModel(post: $0) }
    }
  }
  
  private var redditTopListings = [AdvertViewModel]() {
    didSet {
      let rows = redditTopListings.map { TopListingsRow.advert(viewModel: $0) }
      redditSections = [.top(rows: rows)]
    }
  }
  
  private var redditSections: [TopListingsSection] = []
  
  private var worker: ListingsWorker
  private var viewModelsFactory: AdvertViewModelFactory
  
  init(factory: AdvertViewModelFactory, worker: ListingsWorker) {
    viewModelsFactory = factory
    self.worker = worker
  }
  
}

// MARK: - Private

private typealias Private = RedditTopListingsViewModel
private extension Private {
  
  func fetchFirstPosts(loadingIndicator: Observable<Bool>) {
    loadingIndicator.value = true
    worker.fetchFirstPosts { [weak self] result in
      guard let `self` = self else { return }
      loadingIndicator.value = false
      switch result {
      case .success(let model):
        self.posts = model
        self.reload.notify()
      case .failure(let error):
        self.errorAlertMessage.value = error.localizedDescription
      }
    }
  }
  
  func fetchMorePosts(loadingIndicator: Observable<Bool>) {
    loadingIndicator.value = true
    worker.fetchMorePosts { [weak self] result in
      guard let `self` = self else { return }
      loadingIndicator.value = false
      switch result {
      case .success(let model):
        self.posts.append(contentsOf: model)
        self.reload.notify()
      case .failure(let error):
        self.errorAlertMessage.value = error.localizedDescription
      }
    }
  }
  
}
