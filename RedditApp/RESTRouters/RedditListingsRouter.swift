//
//  RedditListingsRouter.swift
//  RedditApp
//
//  Created by Petrov Anton on 11.08.2020.
//  Copyright © 2020 apm. All rights reserved.
//

import Foundation

enum RedditListingsRouter: RESTRouterProtocol {
  
  case top(data: TopListingsData)
  
  var method: HTTPMethod {
    switch self {
    case .top:
      return .get
    }
  }
  
  var path: String {
    switch self {
    case .top:
      return "/top.json"
    }
  }
  
  var parameters: [String: Any]? {
    switch self {
    case .top(let data):
      return data.encodeParameters
    }
  }
  
}

// MARK: - Payload data 

extension RedditListingsRouter {
  
  struct TopListingsData: Codable {
    let count: UInt
    let limit: UInt
    let after: String?
    let before: String?
  }
  
}
