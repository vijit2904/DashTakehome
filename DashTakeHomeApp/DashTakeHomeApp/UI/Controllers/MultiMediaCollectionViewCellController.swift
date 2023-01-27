//
//  MultiMediaCollectionViewCellController.swift
//  DashTakeHomeApp
//
//  Created by Vijit Munjal on 1/26/23.
//

import UIKit

final class MultiMediaCollectionViewCellController {
     
    private let viewModel: MultiMediaCellViewModel
    
    private var cell: MultiMediaCollectionViewCell?
    
    init(viewModel: MultiMediaCellViewModel) {
        self.viewModel = viewModel
    }
    
    func view(in collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        self.cell = collectionView.dequeueReusableCell(for: indexPath)
        return binded(cell!)
    }
    
    func binded(_ cell: MultiMediaCollectionViewCell) -> MultiMediaCollectionViewCell {
        viewModel.loadImgData()
        
        viewModel.onImageLoadingStateChange = { [weak cell] isLoading in
            cell?.imgContainer.isShimmering = isLoading
        }
        
        cell.title.isHidden = viewModel.isTitleVisible
        cell.title.text = viewModel.title
        cell.desc.isHidden = viewModel.isDescriptionVisible
        cell.desc.text = viewModel.description
        cell.createdat.text = viewModel.memberSince
        
        viewModel.onImageLoad = { [weak cell, weak self]  imageData in
            self?.fadeIn(UIImage(data: imageData))
            cell?.imgContainer.backgroundColor = .clear
        }
        
        return cell
    }
    
    func preload(){
        viewModel.loadImgData()
    }
    
    func cacelLoad(){
        releaseCellForReuse()
        viewModel.cancelImageLoadData()
    }
    
    private func releaseCellForReuse() {
            cell = nil
        }
    
    func fadeIn(_ image: UIImage?){
        cell?.imgView.image = image
        
        UIView.animate(withDuration: 0.3,
                       delay: 0.3, animations: {
            self.cell?.imgView.alpha = 1
        }, completion: { completed in
            if completed {
                self.cell?.imgContainer.isShimmering = false
            }
        })
    }
}
