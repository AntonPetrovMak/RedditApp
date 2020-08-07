//
//  TableViewUtil.swift
//  UpstoxPro
//
//  Created by Shravan Sukumar on 25/05/18.
//  Copyright © 2018 Vinita. All rights reserved.
//

import UIKit

extension UIView {
  
  static var className: String {
    return String(describing: self)
  }
  
  class func getCellIdentifier() -> String {
    return className
  }
  
}

extension UITableView {
  
  func registerNib(viewClass: UIView.Type) {
    let nib = UINib(nibName: viewClass.getCellIdentifier(), bundle: nil)
    register(nib, forCellReuseIdentifier: viewClass.getCellIdentifier())
  }
  
  func registerHeaderFooterNib(viewClass: UIView.Type) {
    let nib = UINib(nibName: viewClass.getCellIdentifier(), bundle: nil)
    register(nib, forHeaderFooterViewReuseIdentifier: viewClass.getCellIdentifier())
  }
  
  func dequeueReusableCell<T: UITableViewCell>(tableViewCellClass: T.Type) -> T {
    return dequeueReusableCell(withIdentifier: tableViewCellClass.getCellIdentifier()) as! T
  }
  
  func dequeueReusableCell<T: UITableViewCell>(tableViewCellClass: T.Type, forIndexPath indexPath: IndexPath) -> T {
    return dequeueReusableCell(withIdentifier: tableViewCellClass.getCellIdentifier(), for: indexPath) as! T
  }
  
  func dequeueReusableHeaderCell<T: UITableViewHeaderFooterView>(tableViewHeaderCellClass: T.Type) -> T {
    return dequeueReusableHeaderFooterView(withIdentifier: tableViewHeaderCellClass.getCellIdentifier()) as! T
  }
  
}
