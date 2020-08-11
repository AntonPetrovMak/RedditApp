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
    loadAdverts(loadingIndicator: isActivityLoading)
  }
  
  func refreshSections() {
    loadAdverts(loadingIndicator: isRefreshLoading)
  }
  
  // MARK: - Private properties
  
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
  
  func loadAdverts(loadingIndicator: Observable<Bool>) {
    loadingIndicator.value = true
    worker.loadTopListings { result in
      loadingIndicator.value = false
      switch result {
      case .success(let model):
        print("S-loadTopListings: \(model)")
      case .failure(let error):
        print("F-loadTopListings:\(error)")
      }
    }
    
    //    DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
    //      DispatchQueue.main.async {
    //        self.redditTopListings = [AdvertViewModel(title: "He saved 22 of his 23 students", fullname: "Jon", numberOfComments: 3),
    //        AdvertViewModel(title: "Reddit meet a person who cleans out COVID rooms. They too put their lives on the line.", fullname: "Mike", numberOfComments: 55),
    //        AdvertViewModel(title: "TIL that in “Forrest Gump,” when his microphone is cut off at the rally, what you don’t hear him say is “Sometimes when people go to Vietnam, they go home to their mommas without any legs. Sometimes they don’t go home at all. That’s a bad thing. That’s all I have to say about that.”", fullname: "Lola", numberOfComments: 1234567890987654321)]
    //        self.reload.notify()
    //        loadingIndicator.value = false
    //      }
    //    }
  }
  
}
