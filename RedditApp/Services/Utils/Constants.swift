//
//  Constants.swift
//  RedditApp
//
//  Created by Petrov Anton on 11.08.2020.
//  Copyright © 2020 apm. All rights reserved.
//

import Foundation

enum Constants {
  
  static let serverConfig = ServerConfig()
  
}

struct ServerConfig: RESTServerConfig {
  var baseURL: String = "https://www.reddit.com"
  var timeoutInterval: Double = RESTClientTimeOuts.defaultInterval
}
