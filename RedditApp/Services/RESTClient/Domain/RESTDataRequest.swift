//
//  RESTDataRequest.swift
//  RedditApp
//
//  Created by Petrov Anton on 11.08.2020.
//  Copyright © 2020 apm. All rights reserved.
//

import Foundation

class RESTDataRequest: RESTDataRequestProtocol {
  
  let request: URLRequest
  let strategy: RESTDecodeStrategy
  
  init(request: URLRequest, strategy: RESTDecodeStrategy) {
    self.request = request
    self.strategy = strategy
  }
  
  func responseDecodableModel<DataType: Decodable>(session: URLSession, completion: @escaping CompletionResultHandler<DataType>) -> URLSessionDataTask {
    session.dataTaskJSONPrint(with: request) { (data, response, error) in
      if let data = data {
        do {
          let decodeObject: DataType = try self.strategy.decode(data: data)
          completion(.success(decodeObject))
        } catch {
          completion(.failure(error))
        }
      } else if let error = error {
        completion(.failure(error))
      } else {
        completion(.failure(RESTError.responseBaseDataNil))
      }
    }
  }
  
  func responseDecodableModels<DataType: Decodable>(session: URLSession, completion: @escaping CompletionResultHandler<[DataType]>) -> URLSessionDataTask {
    session.dataTaskJSONPrint(with: request) { (data, response, error) in
      if let data = data {
        do {
          let decodeObject: [DataType] = try self.strategy.decodeArray(data: data)
          completion(.success(decodeObject))
        } catch {
          completion(.failure(error))
        }
      } else if let error = error {
        completion(.failure(error))
      } else {
        completion(.failure(RESTError.responseBaseDataNil))
      }
    }
  }
}

// MARK: - DataTaskHelper

private typealias DataTaskHelper = URLSession
private extension DataTaskHelper {
  
  func dataTaskJSONPrint(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
    return dataTask(with: request) { (data, response, error) in
      defer { completionHandler(data, response, error) }
      
      if let data = data {
        print("📥\(response?.url?.absoluteString ?? "")")

        guard data.count < 100_000 else {
          print("⚠️RESPONSE: data size is more than 100000 bytes")
          return
        }
        
        print("✅RESPONSE: \(data)")
      } else {
        print("📥\(response?.url?.absoluteString ?? "")\n❌ERROR: \(error?.localizedDescription ?? "nil")")
      }
    }
  }
  
}
