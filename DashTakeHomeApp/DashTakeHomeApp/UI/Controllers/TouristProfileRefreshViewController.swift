//
//  TouristProfileRefreshViewController.swift
//  DashTakeHomeApp
//
//  Created by Vijit Munjal on 1/26/23.
//

import UIKit

final class TouristProfileRefreshViewController: NSObject {
    
    private(set) lazy var view: UIRefreshControl = binded(UIRefreshControl())
    
    private let viewModel: TouristProfileViewModel
    
    init(viewModel: TouristProfileViewModel) {
        self.viewModel = viewModel
    }
    
    @objc func refresh() {
        viewModel.loadTourist()
    }
    
    private func binded(_ view: UIRefreshControl) -> UIRefreshControl {
        viewModel.onLoadingStateChange = { [weak view] isLoading in
            if isLoading {
                view?.beginRefreshing()
            }else {
                view?.endRefreshing()
            }
        }
        view.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return view
    }
    
}
