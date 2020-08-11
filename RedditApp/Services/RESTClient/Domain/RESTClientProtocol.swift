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
  
  static func performRequestWithDecodableModel<DataType: Decodable>(endpoint: RESTRouterProtocol, queue: DispatchQueue, completion: @escaping CompletionResultHandler<DataType>)
  static func performRequestWithDecodableModels<DataType: Decodable>(endpoint: RESTRouterProtocol, queue: DispatchQueue, completion: @escaping CompletionResultHandler<[DataType]>)
  
  static func loadImage(url: URL, completion: @escaping CompletionResultHandler<Data>) -> URLSessionDataTask
}

// MARK: Default properties

extension RESTClientProtocol {
  static func performRequestWithDecodableModel<DataType: Decodable>(endpoint: RESTRouterProtocol, queue: DispatchQueue = DispatchQueue.main, completion: @escaping CompletionResultHandler<DataType>) {
    performRequestWithDecodableModel(endpoint: endpoint, queue: queue, completion: completion)
  }
  static func performRequestWithDecodableModels<DataType: Decodable>(endpoint: RESTRouterProtocol, queue: DispatchQueue = DispatchQueue.main, completion: @escaping CompletionResultHandler<[DataType]>) {
    performRequestWithDecodableModels(endpoint: endpoint, queue: queue, completion: completion)
  }
}
