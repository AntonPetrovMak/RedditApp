//
//  Post.swift
//  RedditApp
//
//  Created by Petrov Anton on 11.08.2020.
//  Copyright © 2020 apm. All rights reserved.
//

import Foundation

struct Post {
  let id: String
  let title: String
  let author: String
  let authorFullname: String
  let thumbnail: String
  let numComments: Int
  let url: String?
  let createdUtc: Double
  let postHint: PostHint?
}

// MARK: - Decodable

extension Post: Decodable {
  
  enum CodingKeys: String, CodingKey {
    case id = "id"
    case title = "title"
    case author = "author"
    case authorFullname = "author_fullname"
    case thumbnail = "thumbnail"
    case numComments = "num_comments"
    case url = "url"
    case createdUtc = "created_utc"
    case postHint = "post_hint"
  }
}
