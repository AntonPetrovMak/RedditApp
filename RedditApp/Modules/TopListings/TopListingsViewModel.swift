//
//  TopListingsViewModel.swift
//  RedditApp
//
//  Created by Petrov Anton on 07.08.2020.
//  Copyright © 2020 apm. All rights reserved.
//

import Foundation

enum TopListingsSection {
  case top(rows: [TopListingsRow])
  
  var rows: [TopListingsRow] {
    switch self {
    case .top(let rows):
      return rows
    }
  }
}

enum TopListingsRow {
  case advert(viewModel: AdvertViewModel)
}

protocol TopListingsViewModel {
  var sections: [TopListingsSection] { get }
  var reload: (() -> Void)? { get set }
}

final class RedditTopListingsViewModel: TopListingsViewModel {
  
  private var redditTopListings: [AdvertViewModel] =
    [AdvertViewModel(title: "He saved 22 of his 23 students", fullname: "Jon"),
     AdvertViewModel(title: "Reddit meet a person who cleans out COVID rooms. They too put their lives on the line.", fullname: "Mike"),
     AdvertViewModel(title: "TIL that in “Forrest Gump,” when his microphone is cut off at the rally, what you don’t hear him say is “Sometimes when people go to Vietnam, they go home to their mommas without any legs. Sometimes they don’t go home at all. That’s a bad thing. That’s all I have to say about that.”", fullname: "Lola")]
  
  var sections: [TopListingsSection] {
    let rows = redditTopListings.map { TopListingsRow.advert(viewModel: $0) }
    return [.top(rows: rows)]
  }
  
  var reload: (() -> Void)?
  
}
