//
//  RESTDecodeStrategy.swift
//  RedditApp
//
//  Created by Petrov Anton on 11.08.2020.
//  Copyright © 2020 apm. All rights reserved.
//

import UIKit

enum RESTDecodeStrategy {
  
  case useOriginal
  case useBaseResponse
  
  func decode<T: Decodable>(data: Data) throws -> T {
    var dataModel: Any?
    switch self {
    case .useOriginal: ()
    case .useBaseResponse:
      let baseResponse = try RESTResponseHandler.convertToBaseResponse(JSONResponse: data)
      dataModel = try RESTResponseHandler.convertToAny(baseResponse: baseResponse)
    }
    return try RESTResponseHandler.convertToDecodable(data: dataModel)
  }
  
  func decodeArray<T: Decodable>(data: Data) throws -> [T] {
    var dataModels: Any?
    switch self {
    case .useOriginal: ()
    case .useBaseResponse:
      let baseResponse = try RESTResponseHandler.convertToBaseResponse(JSONResponse: data)
      dataModels = try RESTResponseHandler.convertToAny(baseResponse: baseResponse)
    }
    return try RESTResponseHandler.convertToDecodableArray(dataModels)
  }
  
}
