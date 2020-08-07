//
//  TopListingsViewController.swift
//  RedditApp
//
//  Created by Petrov Anton on 07.08.2020.
//  Copyright © 2020 apm. All rights reserved.
//

import UIKit

class TopListingsViewController: UIViewController {
  
  // MARK: - IBOutlets
  
  @IBOutlet var tableView: UITableView!
  
  // MARK: - Private
  
  private let viewModel: TopListingsViewModel = RedditTopListingsViewModel()
  
  // MARK: - Life cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupTableView()
  }
  
}

// MARK: - UITableViewDataSource

extension TopListingsViewController: UITableViewDataSource {
  
  func setupTableView() {
    tableView.dataSource = self
    tableView.registerNib(viewClass: AdvertTableViewCell.self)
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return viewModel.sections.count
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    let sectionModel = viewModel.sections[section]
    return sectionModel.rows.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let section = viewModel.sections[indexPath.section]
    
    switch section.rows[indexPath.row] {
    case .advert(let viewModel):
      let cell = tableView.dequeueReusableCell(tableViewCellClass: AdvertTableViewCell.self, forIndexPath: indexPath)
      cell.setupViewModel(viewModel)
      return cell
    }
  }
  
}
