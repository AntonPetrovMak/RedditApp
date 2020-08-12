//
//  UIViewController+Alert.swift
//  RedditApp
//
//  Created by Petrov Anton on 12.08.2020.
//  Copyright © 2020 apm. All rights reserved.
//

import UIKit

extension UIViewController {
  
  func showAlert(title: String?, message: String?, actionTitle: String = "Ok", animated: Bool = true) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let okAction = UIAlertAction(title: actionTitle, style: .default)
    alert.addAction(okAction)
    present(alert, animated: animated)
  }
  
  func showSheet(title: String?, message: String?, actions: [UIAlertAction], animated: Bool = true) {
    let sheet = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
    actions.forEach { sheet.addAction($0) }
    present(sheet, animated: animated)
  }
  
}
