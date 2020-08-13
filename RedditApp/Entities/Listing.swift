//
//  Listing.swift
//  RedditApp
//
//  Created by Petrov Anton on 11.08.2020.
//  Copyright © 2020 apm. All rights reserved.
//

import Foundation

struct Listing: Decodable {
  
  let modhash: String
  let dist: Int
  let children: [ListingChildren]
  let after: String?
  let before: String?
  
}

struct ListingChildren: Decodable {
  
  let kind: String
  let data: Post
  
}

extension Listing {
  
  var posts: [Post] {
    return children.map { $0.data }
  }
  
}
