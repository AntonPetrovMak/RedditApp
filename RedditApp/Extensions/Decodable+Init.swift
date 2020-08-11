//
//  Decodable+Init.swift
//  RedditApp
//
//  Created by Petrov Anton on 11.08.2020.
//  Copyright © 2020 apm. All rights reserved.
//

import Foundation

extension Decodable {
  
  /// Initialization for codable object
  
  static func decodeObject(from dataDict: Any?, dateFormatter: DateFormatter? = nil) throws -> Self? {
    guard let dataDict = dataDict, !(dataDict is NSNull) else { return nil }
    let jsonData: Data = try JSONSerialization.data(withJSONObject: dataDict, options: [.prettyPrinted])
    
    let decoder = JSONDecoder()
    if let dateFormatter = dateFormatter {
      decoder.dateDecodingStrategy = .formatted(dateFormatter)
    }
    
    return try decoder.decode(Self.self, from: jsonData)
  }
  
  static func decodeObjects(from dataDict: Any?, dateFormatter: DateFormatter? = nil) throws -> [Self]? {
    guard let dataDict = dataDict as? [Any] else { return nil }
    let jsonData: Data = try JSONSerialization.data(withJSONObject: dataDict, options: [.prettyPrinted])
    
    let decoder = JSONDecoder()
    if let dateFormatter = dateFormatter {
      decoder.dateDecodingStrategy = .formatted(dateFormatter)
    }
    
    return try decoder.decode([Self].self, from: jsonData)
  }
}

extension Encodable {
  var encodeData: Data? {
    return try? JSONEncoder().encode(self)
  }
  
  var encodeStringUTF8: String? {
    guard let jsonString = self.encodeData?.stringUTF8 else { return nil }
    return jsonString
  }
  
  var encodeParameters: [String: Any]? {
    guard let dict = self.encodeData?.simpleSerialize as? [String: Any] else { return nil }
    return dict
  }
}

extension Data {
  var simpleSerialize: Any? {
    return try? JSONSerialization.jsonObject(with: self, options: [])
  }
  
  var stringUTF8: String? {
    return String(data: self, encoding: .utf8)
  }
}
