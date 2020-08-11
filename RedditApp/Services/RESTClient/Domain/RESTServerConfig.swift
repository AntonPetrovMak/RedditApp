//
//  RESTServer.swift
//  RedditApp
//
//  Created by Petrov Anton on 11.08.2020.
//  Copyright © 2020 apm. All rights reserved.
//

protocol RESTServerConfig {
  var baseURL: String { get }
  var timeoutInterval: Double { get }
}
