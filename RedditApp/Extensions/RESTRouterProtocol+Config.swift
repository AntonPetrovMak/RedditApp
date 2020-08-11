//
//  RESTRouterProtocol+Config.swift
//  RedditApp
//
//  Created by Petrov Anton on 11.08.2020.
//  Copyright © 2020 apm. All rights reserved.
//

extension RESTRouterProtocol {
  
  var serverConfig: RESTServerConfig {
    // TODO: here we can separate server configure by environments
    return Constants.serverConfig
  }
  
}
