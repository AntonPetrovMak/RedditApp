//
//  URL+Verify.swift
//  RedditApp
//
//  Created by Petrov Anton on 11.08.2020.
//  Copyright © 2020 apm. All rights reserved.
//

import UIKit

extension URL {
  
  var canOpenURL: Bool {
    return UIApplication.shared.canOpenURL(self)
  }
  
}
