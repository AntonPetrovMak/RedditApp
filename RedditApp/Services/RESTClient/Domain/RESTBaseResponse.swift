//
//  RESTBaseResponse.swift
//  RedditApp
//
//  Created by Petrov Anton on 11.08.2020.
//  Copyright © 2020 apm. All rights reserved.
//

struct RESTBaseResponse {
  
  let data: Any?
  let kind: String
  
  init(from dataDict: [String: Any]) throws {
    data = dataDict[CodingKeys.data.rawValue]
    
    guard let _kind = dataDict[CodingKeys.kind.rawValue] as? String else {
      let context = DecodingError.Context(codingPath: [CodingKeys.kind], debugDescription: "")
      throw DecodingError.keyNotFound(CodingKeys.kind, context)
    }
    
    kind = _kind
  }
  
  enum CodingKeys: String, CodingKey {
    case data
    case kind
  }

}
