//
//  TouristDetailsCellContller.swift
//  DashTakeHomeApp
//
//  Created by Vijit Munjal on 1/26/23.
//

import UIKit

final class TouristDetailsCellContller {
    
    private let viewModel: TouristProfileCellViewModel
    
    init(viewModel: TouristProfileCellViewModel) {
        self.viewModel = viewModel
    }
    
    func view(in tableView: UITableView) -> UITableViewCell {
        let cell: TouristProfileDetailsCell = tableView.dequeueReusableCell()
        return binded(cell)
    }
    
    private func binded(_ cell: TouristProfileDetailsCell) -> TouristProfileDetailsCell {
        cell.nameTxt.text = viewModel.name
        cell.emailTxt.text = viewModel.email
        cell.loactionTxt.text = viewModel.location
        cell.memberSinceTxt.text = viewModel.memberSince
        cell.tintColor = .label
        return cell
    }
}
