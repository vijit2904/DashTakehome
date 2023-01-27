//
//  TouristDetailsTableViewController.swift
//  DashTakeHomeApp
//
//  Created by Vijit Munjal on 1/26/23.
//

import UIKit

class TouristDetailsTableViewController: UITableViewController {
    
    private var refreshController: TouristDetailsRefreshViewController?
    
    var tableModel = [TouristDetailsCellContller](){
        didSet { tableView.reloadData() }
    }
    
   convenience init(refreshController: TouristDetailsRefreshViewController?) {
       self.init()
       self.refreshController = refreshController
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.allowsSelection = false
        refreshControl = refreshController?.view
        tableView.backgroundColor = .systemBackground
        UITableView.appearance().tintColor = .systemBackground
        
        tableView.register(TouristProfileDetailsCell.self, forCellReuseIdentifier: String(describing: TouristProfileDetailsCell.self))
        tableView.separatorColor = .label
        tableView.separatorInset = .zero
        refreshController?.refresh()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableModel.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableModel[indexPath.row].view(in: tableView)
    }

}
