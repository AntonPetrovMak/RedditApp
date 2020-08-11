//
//  RESTDataRequestProtocol.swift
//  RedditApp
//
//  Created by Petrov Anton on 11.08.2020.
//  Copyright © 2020 apm. All rights reserved.
//

import UIKit

protocol RESTDataRequestProtocol: class {
  func responseDecodableModel<DataType: Decodable>(session: URLSession, completion: @escaping CompletionResultHandler<DataType>) -> URLSessionDataTask
  func responseDecodableModels<DataType: Decodable>(session: URLSession, completion: @escaping CompletionResultHandler<[DataType]>) -> URLSessionDataTask
}
