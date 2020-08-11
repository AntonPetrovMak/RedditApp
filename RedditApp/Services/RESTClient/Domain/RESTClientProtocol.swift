//
//  RESTClientProtocol.swift
//  RedditApp
//
//  Created by Petrov Anton on 11.08.2020.
//  Copyright © 2020 apm. All rights reserved.
//

import UIKit

protocol RESTClientProtocol {
  static func request(endpoint: RESTRouterProtocol) throws -> RESTDataRequestProtocol
  
  static func performRequestWithDecodableModel<DataType: Decodable>(endpoint: RESTRouterProtocol, completion: @escaping CompletionResultHandler<DataType>)
  static func performRequestWithDecodableModels<DataType: Decodable>(endpoint: RESTRouterProtocol, completion: @escaping CompletionResultHandler<[DataType]>)
}
