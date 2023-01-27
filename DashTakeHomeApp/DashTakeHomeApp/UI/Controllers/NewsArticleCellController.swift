//
//  NewsArticleCellController.swift
//  DashTakeHomeApp
//
//  Created by Vijit Munjal on 1/25/23.
//

import UIKit

final class NewsArticleCellControlle {
    
    private let viewModel: NewsArticleCellViewModel
    
    private var cell: NewsArticleCell?
    
    init(viewModel: NewsArticleCellViewModel) {
        self.viewModel = viewModel
    }
    
    func view(in tableView: UITableView) -> UITableViewCell {
        self.cell = tableView.dequeueReusableCell()
        return binded(cell!)
    }
    
    private func binded(_ cell: NewsArticleCell) -> NewsArticleCell {
        
        cell.title.isHidden = viewModel.isTitleVisible
        cell.title.text = viewModel.title
        cell.desc.isHidden = viewModel.isDescriptionVisible
        cell.desc.text = viewModel.description
        cell.location.text = viewModel.location
        cell.createdat.text = viewModel.date
        cell.userName.text = viewModel.userName
    
        viewModel.onImageLoad = { [weak self] imageData in
            self?.fadeIn(UIImage(data: imageData))
        }
        
        viewModel.onImageLoadingStateChange = { [weak cell] isLoading in
            cell?.profileImageView.isShimmering = isLoading
        }
        cell.commentCount.text = viewModel.noOfComments
        cell.multiMediaView.view.isHidden = viewModel.isMultiMediaVisible
        cell.multiMediaView.collectionModel = viewModel.getMultiMediaCellController()
        
        viewModel.loadImageData()
        return cell
    }
    
    func preload(){
        viewModel.loadImageData()
    }
    
    func cacelLoad(){
        releaseCellForReuse()
        viewModel.cancelImageLoadData()
    }
    
    private func releaseCellForReuse() {
            cell = nil
        }
    
    func fadeIn(_ image: UIImage?){
        cell?.profileImageView.image = image
        
        UIView.animate(withDuration: 0.3,
                       delay: 0.3, animations: {
            self.cell?.profileImageView.alpha = 1
        }, completion: { completed in
            if completed {
                self.cell?.profileImageView.isShimmering = false
            }
        })
    }
}

