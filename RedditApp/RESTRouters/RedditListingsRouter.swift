//
//  RedditListingsRouter.swift
//  RedditApp
//
//  Created by Petrov Anton on 11.08.2020.
//  Copyright © 2020 apm. All rights reserved.
//

import Foundation

enum RedditListingsRouter: RESTRouterProtocol {
  
  case top
  
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
  
  var parameters: [String : String]? {
    return nil
  }
  
}
