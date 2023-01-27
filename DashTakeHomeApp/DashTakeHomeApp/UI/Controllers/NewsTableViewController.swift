//
//  NewsTableViewController.swift
//  DashTakeHomeApp
//
//  Created by Vijit Munjal on 1/25/23.
//

import UIKit

class NewsTableViewController: UITableViewController, UITableViewDataSourcePrefetching {
    
    private var refreshController: NewsTableRefeshViewController?
    
    private var loadingControllers = [IndexPath: NewsArticleCellControlle]()
    
    private var viewModel: NewsArticleViewModel?
    
    var tableModel = [NewsArticleCellControlle]()
    
   convenience init(refreshController: NewsTableRefeshViewController?, viewModel: NewsArticleViewModel) {
       self.init()
       self.refreshController = refreshController
       self.viewModel = viewModel
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.allowsSelection = false
        tableView.prefetchDataSource = self
        refreshControl = refreshController?.view
        tableView.backgroundColor = .systemBackground
        UITableView.appearance().tintColor = .systemBackground
        
        tableView.register(NewsArticleCell.self, forCellReuseIdentifier: String(describing: NewsArticleCell.self))
        tableView.separatorColor = .label
        tableView.separatorInset = .zero
        refreshController?.refresh()
        
        viewModel?.reloadNewFetchedRows = { [weak self] newCount in
            let newPaths = Helper.newIndexPaths(added: newCount, current: self?.tableModel.count ?? 0)
            let indexPathsToReload = Helper.indexPathsForReload(intersecting: newPaths, visibleRows: self?.tableView.indexPathsForVisibleRows ?? [])
            if indexPathsToReload.count > 0 {
                self?.tableView.reloadRows(at: indexPathsToReload, with: .automatic)
            }else {
                self?.tableView.reloadData()
            }
        }
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableModel.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableModel[indexPath.row].view(in: tableView)
    }

    override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cancelCellControllerLoad(forRowAt: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cellController(forRowAt: indexPath).preload()
    }
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        let count = tableModel.count
        indexPaths.forEach { indexPath in
            cellController(forRowAt: indexPath).preload()
            if Helper.needToloadMore(for: indexPath, model: count) {
                viewModel?.loadNextPage()
            }
        }
    }
   
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        indexPaths.forEach(cancelCellControllerLoad)
    }
    
    private func cellController(forRowAt indexPath: IndexPath) -> NewsArticleCellControlle {
        let controller = tableModel[indexPath.row]
        loadingControllers[indexPath] = controller
        return controller
    }
    
    private func cancelCellControllerLoad(forRowAt indexPath: IndexPath){
        loadingControllers[indexPath]?.cacelLoad()
        loadingControllers[indexPath] = nil
    }
}
