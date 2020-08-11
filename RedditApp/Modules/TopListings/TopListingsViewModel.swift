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
  var reload: ObservableEmpty { get set }
  var isActivityLoading: Observable<Bool> { get set }
  var isRefreshLoading: Observable<Bool> { get set }
  
  func doLaunch()
  func refreshSections()
  func loadMoreSections()
}
