//
//  RESTRouterProtocol.swift
//  RedditApp
//
//  Created by Petrov Anton on 11.08.2020.
//  Copyright © 2020 apm. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
  case get
  case post
}

protocol URLRequestConvertible {
  func asURLRequest() throws -> URLRequest
}

protocol RESTRouterProtocol: URLRequestConvertible {
  var serverConfig: RESTServerConfig { get }
  var method: HTTPMethod { get }
  var path: String { get }
  var parameters: [String: Any]? { get }
  var baseServerURL: String { get }
  var decodeStrategy: RESTDecodeStrategy { get }
  var timeoutInterval: Double { get }
  func requestHeaders() throws -> [String: String?]
}

// MARK: - Default implementation

extension RESTRouterProtocol {
  
  var baseServerURL: String {
    return serverConfig.baseURL
  }
  
  var decodeStrategy: RESTDecodeStrategy {
    .useBaseResponse
  }
  
  var timeoutInterval: Double {
    return serverConfig.timeoutInterval
  }
  
  func requestHeaders() throws -> [String: String?] {
    return ["Content-Type": "application/json"]
  }
}

// MARK: - URLRequestConvertible

extension RESTRouterProtocol {
  
  func asURLRequest() throws -> URLRequest {
    
    let urlStr = baseServerURL.appending(path)
    
    guard let url = URL(string: urlStr) else {
      throw RESTError.wrongURL
    }
    var urlRequest = URLRequest(url: url)
    
    // HTTP Method
    urlRequest.httpMethod = method.rawValue
    urlRequest.timeoutInterval = timeoutInterval
    
    // Common Headers
    
    let headers = try requestHeaders()
    headers.forEach { urlRequest.setValue($0.value, forHTTPHeaderField: $0.key) }
    
    // Parameters
    if let parameters = parameters {
      switch self.method {
      case .get:
        urlRequest = URLRequest(url: addURLQueryParameters(toURL: url, parameters: parameters))
      case .post:
        do {
          urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
        } catch {
          throw RESTError.wrongRequestParameters
        }
      }
    }
    
    return urlRequest
  }
  
  private func addURLQueryParameters(toURL url: URL, parameters: [String: Any]) -> URL {
    guard parameters.count > 0,
      var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
      else { return url }
    
    urlComponents.queryItems = parameters.map {
      let value = "\($0.value)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
      return URLQueryItem(name: $0.key, value: value)
    }
    
    guard let updatedURL = urlComponents.url else { return url }
    return updatedURL
  }
  
}
