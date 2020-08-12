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
  @IBOutlet var activityView: UIActivityIndicatorView!
  
  // MARK: - Private
  
  private var viewModel: TopListingsViewModel = {
    let store = RedditListingsStore()
    let worker = RedditListingsWorker(store: store)
    let factory = RedditAdvertViewModelFactory()
    return RedditTopListingsViewModel(factory: factory, worker: worker)
  }()
  
  private lazy var refreshControl: UIRefreshControl = {
    let _refreshControl = UIRefreshControl()
    _refreshControl.addTarget(self, action: #selector(pullToRefresh(_:)), for: .valueChanged)
    return _refreshControl
  }()
  
  // MARK: - Life cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupTableView()
    bind()
    viewModel.doLaunch()
  }
  
}
// MARK: - Private

private extension TopListingsViewController {
  
  func bind() {
    viewModel.reload.observeWithStartingValue(on: self) { [weak self] in
      guard let `self` = self else { return }
      self.tableView.reloadData()
    }
    
    viewModel.isActivityLoading.observe(on: self) { [weak self] isLoading in
      guard let `self` = self,
        self.activityView.isAnimating != isLoading else { return }
      isLoading ? self.activityView.startAnimating() : self.activityView.stopAnimating()
    }
    
    viewModel.isRefreshLoading.observe(on: self) { [weak self] isLoading in
      guard let `self` = self,
        self.refreshControl.isRefreshing != isLoading else { return }
      isLoading ? self.refreshControl.beginRefreshing() : self.refreshControl.endRefreshing()
    }
    
    viewModel.errorAlertMessage.observe(on: self) { [weak self] message in
      self?.showAlert(title: "Error", message: message)
    }
    
  }
  
  // MARK: - Actions
  
  @objc func pullToRefresh(_ refreshControl: UIRefreshControl) {
    viewModel.refreshSections()
  }
  
}


// MARK: - UITableViewDataSource & UITableViewDelegate

extension TopListingsViewController: UITableViewDataSource, UITableViewDelegate {
  
  private func setupTableView() {
    tableView.dataSource = self
    tableView.delegate = self
    tableView.registerNib(viewClass: AdvertTableViewCell.self)
    tableView.backgroundView = refreshControl
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
    
    if indexPath.row == section.rows.count - 1 {
      viewModel.loadMoreSections()
    }
    
    switch section.rows[indexPath.row] {
    case .advert(let viewModel):
      let cell = tableView.dequeueReusableCell(tableViewCellClass: AdvertTableViewCell.self, forIndexPath: indexPath)
      cell.setupViewModel(viewModel)
      return cell
    }
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let section = viewModel.sections[indexPath.section]
    switch section.rows[indexPath.row] {
    case .advert(let rowViewModel):
      guard let contentImageURL = rowViewModel.contentImageURL else { return }
      presentPreviewImage(imageURL: contentImageURL)
    }
  }
  
  func presentPreviewImage(imageURL: URL) {
    guard let previewImageViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PreviewImageViewController") as? PreviewImageViewController else { return }
    
    previewImageViewController.viewModel = RedditPreviewImageViewModel(previewImageURL: imageURL)
    navigationController?.pushViewController(previewImageViewController, animated: true)
  }
  
}
