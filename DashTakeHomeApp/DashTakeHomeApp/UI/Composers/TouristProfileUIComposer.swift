//
//  TouristProfileUIComposer.swift
//  DashTakeHomeApp
//
//  Created by Vijit Munjal on 1/26/23.
//

import Foundation
import DashTakeHomeLib

final class TouristProfileUIComposer {
    
    private init(){}
    
    static func touristProfileComposedWith(touristInfoLoader: TouristInfoLoader) -> TouristProfileTableViewController {
        let viewModel = TouristProfileViewModel(loader: MainQueueDispatchDecorator(decoratee: touristInfoLoader))
        let refreshController = TouristProfileRefreshViewController(viewModel: viewModel)
        let touristProfileController = TouristProfileTableViewController(refreshController: refreshController, viewModel: viewModel)
        viewModel.onTouristLoad = { [weak touristProfileController] tourist in
            let cellController = tourist.info.map{ info in
                TouristProfileCellContller(viewModel: TouristProfileCellViewModel(model: info))
            }
            touristProfileController?.tableModel.append(contentsOf: cellController)
        }
        return touristProfileController
    }
}
