//
//  TouristProfileCellContller.swift
//  DashTakeHomeApp
//
//  Created by Vijit Munjal on 1/26/23.
//
import UIKit

final class TouristProfileCellContller {
    
    private let viewModel: TouristProfileCellViewModel
    
    init(viewModel: TouristProfileCellViewModel) {
        self.viewModel = viewModel
    }
    
    func view(in tableView: UITableView) -> UITableViewCell {
        let cell: TouristProfileCell = tableView.dequeueReusableCell()
        return binded(cell)
    }
    
    private func binded(_ cell: TouristProfileCell) -> TouristProfileCell {
        cell.nameTxt.text = viewModel.name
        cell.emailTxt.text = viewModel.email
        cell.loactionTxt.text = viewModel.location
        cell.memberSinceTxt.text = viewModel.memberSince
        cell.accessoryType = .disclosureIndicator
        cell.tintColor = .label
        return cell
    }
    
    func fetchTouristDetailsURL() -> URL {
        return viewModel.getDetailsUrl
    }
}
