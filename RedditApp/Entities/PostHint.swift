//
//  PostHint.swift
//  RedditApp
//
//  Created by Petrov Anton on 11.08.2020.
//  Copyright © 2020 apm. All rights reserved.
//

import Foundation

enum PostHint: String, EnumDecodable {
  
  case image
  case link
  case undefined
  
  static var defaultDecoderValue = PostHint.undefined
  
  init(rawValue: String) {
    switch rawValue.lowercased() {
    case "image":
      self = .image
    case "link":
      self = .link
    default:
      self = PostHint.defaultDecoderValue
    }
  }
}
