//
//  RESTClient.swift
//  RedditApp
//
//  Created by Petrov Anton on 11.08.2020.
//  Copyright © 2020 apm. All rights reserved.
//

import Foundation

typealias CompletionResultHandler<T> = (Result<T, Error>) -> Void

final class RESTClient: RESTClientProtocol {
  
  private static let session: URLSession = {
    let sessionConfiguration = URLSessionConfiguration.default
    return URLSession(configuration: sessionConfiguration)
  }()
  
  private init() {}
  
  static func request(endpoint: RESTRouterProtocol) throws -> RESTDataRequestProtocol {
    let request = try endpoint.asURLRequest()
    return RESTDataRequest(request: request, strategy: endpoint.decodeStrategy)
  }
  
  /// Adds a handler to be called once the request has finished. Handler contains arguments which for success case contain a decodable model.
  ///
  /// - Parameters:
  ///   - endpoint: A container with contain data for request
  ///   - queue: a queue for completion
  ///   - completion: A closure to be executed once the request has finished.
  static func performRequestWithDecodableModel<DataType: Decodable>(endpoint: RESTRouterProtocol, queue: DispatchQueue, completion: @escaping CompletionResultHandler<DataType>) {
    do {
      let _request = try request(endpoint: endpoint)
      _request.responseDecodableModel(session: session, completion: { result in
        queue.async { completion(result) }
      }).resume()
    } catch {
      completion(.failure(error))
    }
  }
  
  /// Adds a handler to be called once the request has finished. Handler contains arguments which for success case contain array with decodable models.
  ///
  /// - Parameters:
  ///   - endpoint: A container with contain data for request
  ///   - queue: a queue for completion
  ///   - completion: A closure to be executed once the request has finished.
  static func performRequestWithDecodableModels<DataType: Decodable>(endpoint: RESTRouterProtocol, queue: DispatchQueue = DispatchQueue.main, completion: @escaping CompletionResultHandler<[DataType]>) {
    do {
      let _request = try request(endpoint: endpoint)
      _request.responseDecodableModels(session: session, completion: { result in
        queue.async { completion(result) }
      }).resume()
    } catch {
      completion(.failure(error))
    }
  }
  
  /// Method loaded an image data
  ///
  /// - Parameters:
  ///   - url: a valid url on an image
  ///   - completion: A closure to be executed once the request has finished.
  static func loadImage(url: URL, completion: @escaping CompletionResultHandler<Data>) -> URLSessionDataTask {
    let request = URLRequest(url: url)
    
    let task = session.dataTask(with: request) { (data, response, error) in
      if let data = data {
        completion(.success(data))
      } else {
        completion(.failure(error ?? RESTError.responseBaseDataNil))
      }
    }
    task.resume()
    
    return task
  }
}
