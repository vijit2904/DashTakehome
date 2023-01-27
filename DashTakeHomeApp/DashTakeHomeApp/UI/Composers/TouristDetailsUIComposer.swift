//
//  TouristDetailsUIComposer.swift
//  DashTakeHomeApp
//
//  Created by Vijit Munjal on 1/26/23.
//

import Foundation
import DashTakeHomeLib

final class TouristDetailsUIComposer {
    
    private init(){}
    
    static func touristDetailsComposedWith(url: URL, loader: TouristDetailsLoader) -> TouristDetailsTableViewController {
        let viewModel = TouristDetailsViewModel(loader: MainQueueDispatchDecorator(decoratee: loader), url: url)
        let refreshController = TouristDetailsRefreshViewController(viewModel: viewModel)
        let tdController = TouristDetailsTableViewController(refreshController: refreshController)
        viewModel.onTouristLoad = { [weak tdController] detail in
            tdController?.tableModel = [TouristDetailsCellContller(viewModel: TouristProfileCellViewModel(model: detail))]
        }
        return tdController
    }
}
