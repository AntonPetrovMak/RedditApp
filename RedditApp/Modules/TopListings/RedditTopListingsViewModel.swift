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
      redditTopListings = posts.map {
        var avatarURL: URL?
        if let url = URL(string: $0.thumbnail), url.canOpenURL {
          avatarURL = url
        }
        
        var contentImageURL: URL?
        if $0.postHint == .image,
          let urlStr = $0.url,
          let url = URL(string: urlStr), url.canOpenURL {
          contentImageURL = url
        }
        
        return AdvertViewModel(title: $0.title,
                               fullname: $0.author,
                               numberOfComments: $0.numComments,
                               avatarURL: avatarURL,
                               contentImageURL: contentImageURL)
      }
    }
  }
  
  private var redditTopListings = [AdvertViewModel]() {
    didSet {
      let rows = redditTopListings.map { TopListingsRow.advert(viewModel: $0) }
      redditSections = [.top(rows: rows)]
    }
  }
  
  private var redditSections: [TopListingsSection] = []
  private var worker: ListingsWorker = {
    let store = RedditListingsStore()
    return RedditListingsWorker(store: store)
  }()
  
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
        // TODO: display error
        print("F-loadTopListings:\(error)")
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
        // TODO: display error
        print("F-loadTopListings:\(error)")
      }
    }
  }
  
}
