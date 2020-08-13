//
//  AdvertViewModelFactory.swift
//  RedditApp
//
//  Created by Petrov Anton on 12.08.2020.
//  Copyright © 2020 apm. All rights reserved.
//

import Foundation

protocol AdvertViewModelFactory {
  func makeAdvertViewModel(post: Post) -> AdvertViewModel
}

struct RedditAdvertViewModelFactory: AdvertViewModelFactory {
  
  func makeAdvertViewModel(post: Post) -> AdvertViewModel {
    var avatarURL: URL?
    if let url = URL(string: post.thumbnail) {
      avatarURL = url
    }
    
    var contentImageURL: URL?
    if post.postHint == .image,
      let urlStr = post.url,
      let url = URL(string: urlStr) {
      contentImageURL = url
    }
    
    let date = Date(timeIntervalSince1970: post.createdUtc)
    let interval = Calendar.current.dateComponents([.hour], from: date, to: Date())
    let hour = interval.hour ?? 0
    let hourWord = hour <= 1 ? "hour" : "hours"
    let createdDate = "\(hour) \(hourWord) ago"
    
    return AdvertViewModel(title: post.title,
                           fullname: post.author,
                           numberOfComments: post.numComments,
                           avatarURL: avatarURL,
                           contentImageURL: contentImageURL,
                           createdDate: createdDate)
  }
}
