//
//  RESTResponseHandler.swift
//  RedditApp
//
//  Created by Petrov Anton on 11.08.2020.
//  Copyright © 2020 apm. All rights reserved.
//

import Foundation

enum RESTResponseHandler {
  
  static func convertToBaseResponse(JSONResponse data: Data) throws -> RESTBaseResponse {
    let jsonData = try JSONSerialization.jsonObject(with: data, options: [.allowFragments])
    
    if let dictData = jsonData as? [String: Any] {
      let baseResponse = try RESTBaseResponse(from: dictData)
      return baseResponse
    } else {
      throw RESTError.responseBaseDecodingFailure
    }
  }
  
  static func convertToAny(baseResponse model: RESTBaseResponse) throws -> Any {
    if let data = model.data, !(data is NSNull) {
      return data
    } else {
      throw RESTError.responseBaseDataNil
    }
  }
  
  static func convertToDecodable<DataType: Decodable>(data: Any?) throws -> DataType {
    if let model = try? DataType.decodeObject(from: data) {
      return model
    } else {
      throw RESTError.responseDataDecodingFailure
    }
  }
  
  static func convertToDecodableArray<DataType: Decodable>(_ data: Any?) throws -> [DataType] {
    if let model = try? DataType.decodeObjects(from: data) {
      return model
    } else {
      throw RESTError.responseDataDecodingFailure
    }
  }
  
}
