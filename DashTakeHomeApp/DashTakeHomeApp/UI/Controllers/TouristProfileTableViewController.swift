//
//  TouristProfileTableViewController.swift
//  DashTakeHomeApp
//
//  Created by Vijit Munjal on 1/26/23.
//

import UIKit

class TouristProfileTableViewController: UITableViewController, UITableViewDataSourcePrefetching {
    
    private var refreshController: TouristProfileRefreshViewController?
    
    private var viewModel: TouristProfileViewModel?
    
    private var loadingControllers = [IndexPath: TouristProfileCellContller]()
    
    var tableModel = [TouristProfileCellContller]()
    
    convenience init(refreshController: TouristProfileRefreshViewController?, viewModel: TouristProfileViewModel) {
       self.init()
       self.viewModel = viewModel
       self.refreshController = refreshController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.allowsMultipleSelection = false
        tableView.prefetchDataSource = self
        refreshControl = refreshController?.view
        tableView.backgroundColor = .systemBackground
        UITableView.appearance().tintColor = .systemBackground
        
        tableView.register(TouristProfileCell.self, forCellReuseIdentifier: String(describing: TouristProfileCell.self))
        tableView.separatorColor = .label
        tableView.separatorInset = .zero
        refreshController?.refresh()
        
        viewModel?.reloadNewFetchRows = { [weak self] newCount in
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let loader = viewModel?.getLoaderForDetail() else { return }
        let url = tableModel[indexPath.row].fetchTouristDetailsURL()
        let tdVC = TouristDetailsUIComposer.touristDetailsComposedWith(url: url, loader: loader)
        show(tdVC, sender: nil)
    }

    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        let count = tableModel.count
        if indexPaths.contains(where: { Helper.needToloadMore(for: $0, model: count) }) {
            viewModel?.loadNextPage()
        }
    }

    
}
