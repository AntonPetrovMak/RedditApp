//
//  Enum+Decodable.swift
//  RedditApp
//
//  Created by Petrov Anton on 11.08.2020.
//  Copyright © 2020 apm. All rights reserved.
//

import Foundation

protocol EnumDecodable: RawRepresentable, Decodable {
  static var defaultDecoderValue: Self { get }
}

extension EnumDecodable where RawValue: Decodable {
  init(from decoder: Decoder) throws {
    let value = try decoder.singleValueContainer().decode(RawValue.self)
    self = Self(rawValue: value) ?? Self.defaultDecoderValue
  }
}

extension Int {
  init(from decoder: Decoder) throws {
    let value = try decoder.singleValueContainer().decode(Int.self)
    self = value
  }
}
