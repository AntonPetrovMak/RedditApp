//
//  RESTError.swift
//  RedditApp
//
//  Created by Petrov Anton on 11.08.2020.
//  Copyright © 2020 apm. All rights reserved.
//

import Foundation

enum RESTError: Error {
  case wrongURL
  case wrongRequestParameters
  case responseBaseDecodingFailure
  case responseDataDecodingFailure
  case somethingWentWrong
  case responseBaseDataNil
  case responseTimedOut
}

// MARK: - LocalizedError

extension RESTError: LocalizedError {
  private static let commonErrorMessage = "Something went wrong. Please try again."
  
  public var errorDescription: String? {
    switch self {
    case .wrongURL,
         .wrongRequestParameters,
         .responseBaseDecodingFailure,
         .responseDataDecodingFailure,
         .somethingWentWrong,
         .responseBaseDataNil,
         .responseTimedOut:
         return RESTError.commonErrorMessage
    }
  }
}
