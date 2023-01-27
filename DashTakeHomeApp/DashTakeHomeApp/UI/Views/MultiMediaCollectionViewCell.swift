//
//  MultiMediaCollectionViewCell.swift
//  DashTakeHomeApp
//
//  Created by Vijit Munjal on 1/26/23.
//

import UIKit

class MultiMediaCollectionViewCell: UICollectionViewCell {
    
        lazy var title: UILabel = {
            return UILabel.lableWithPreferredFont(for: .title2)
        }()
    
        lazy var desc: UILabel = {
            let lbl = UILabel.lableWithPreferredFont(for: .body)
            lbl.numberOfLines = 0
            return lbl
        }()
    
        lazy var createdat: UILabel = {
            return UILabel.lableWithPreferredFont(for: .caption2)
        }()
    
        lazy var imgView: UIImageView = {
            let imgView = UIImageView()
            imgView.image = UIImage.make(withColor: .clear, width: frame.width, height: frame.height)
            imgView.contentMode = .scaleAspectFit
            return imgView
        }()
    
    lazy var imgContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        view.layer.cornerRadius = 25.0
        view.clipsToBounds = true
        addConstraint(for: imgView,
                      contentView: view,
                      topbottomAnchor: 0,
                      leadTralAnchor: 0)
        return view
    }()
        
    override init(frame: CGRect) {
        super.init(frame: CGRect.zero)
        setforMode()
        setView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setforMode()
        setView()
    }
    
    private func setforMode() {
        self.contentView.backgroundColor = .systemBackground
        self.backgroundColor = .systemBackground
    }
    
    private func setView() {
        let vstack = embedinVStack([title, createdat, desc, imgContainer])
        addConstraint(for: vstack, contentView: contentView, topbottomAnchor: 0, leadTralAnchor: 0)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        title.text = ""
        desc.text = ""
        createdat.text = ""
        imgView.alpha = 0
    }
}
