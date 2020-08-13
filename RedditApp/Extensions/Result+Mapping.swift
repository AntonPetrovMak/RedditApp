//
//  Result+Mapping.swift
//  RedditApp
//
//  Created by Petrov Anton on 11.08.2020.
//  Copyright © 2020 apm. All rights reserved.
//

import Foundation

extension Result {
  
  func mapSuccess(_ transform: (Success) -> Void) {
    switch self {
    case .success(let success):
      transform(success)
    case .failure: ()
    }
  }
  
  func mapFailure(_ transform: (Failure) -> Void) {
    switch self {
    case .success: ()
    case .failure(let failure):
      transform(failure)
    }
  }
  
}
