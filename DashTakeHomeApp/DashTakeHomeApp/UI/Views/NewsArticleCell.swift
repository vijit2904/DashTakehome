//
//  NewsArticleCell.swift
//  DashTakeHomeApp
//
//  Created by Vijit Munjal on 1/25/23.
//

import UIKit

class NewsArticleCell: UITableViewCell {
    
    
    lazy var title: UILabel = {
        return UILabel.lableWithPreferredFont(for: .title1)
    }()
    
    lazy var desc: UILabel = {
        let lbl = UILabel.lableWithPreferredFont(for: .body)
        lbl.numberOfLines = 0
        return lbl
    }()
    
    lazy var location: UILabel = {
        return UILabel.lableWithPreferredFont(for: .caption1)
    }()
    
    lazy var createdat: UILabel = {
        return UILabel.lableWithPreferredFont(for: .caption1)
    }()
    
    lazy var userName: UILabel = {
        let lbl = UILabel.lableWithPreferredFont(for: .caption1)
        lbl.textAlignment = .left
        return lbl
    }()
    
    lazy var profileImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(systemName: "person.circle.fill")
        imgView.tintColor = .label
        return imgView
    }()
    
   lazy var multiMediaView: MultiMediaCollectionViewController = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
       flowLayout.itemSize = CGSize(width: frame.width, height: frame.width)
       return MultiMediaCollectionViewController(collectionViewLayout: flowLayout)
    }()
    
    lazy var commentCount: UILabel = {
        return UILabel.lableWithPreferredFont(for: .caption1)
    }()
   
    lazy var commentCountImg: UIImageView = {
        let view = UIImageView(image: UIImage(systemName: "captions.bubble"))
        view.tintColor = .label
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
        let imageSize: CGFloat = 30.0
        let loactionDateView = embedinHStack([location, createdat])
        let commentCountView = embedinHStack([commentCountImg, commentCount])
        let userView = embedinHStack([profileImageView, userName])
        let userCommentView = embedinHStack([userView, commentCountView])
        let vStack = embedinVStack([title, loactionDateView, desc, multiMediaView.view, userCommentView])
        addConstraint(for: vStack, contentView: contentView)
        multiMediaView.view.heightAnchor.constraint(equalToConstant: contentView.frame.width).isActive = true
        let wCont = multiMediaView.view.widthAnchor.constraint(equalToConstant: contentView.frame.width)
        wCont.priority = UILayoutPriority(750)
        wCont.isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: imageSize).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: imageSize).isActive = true
        profileImageView.layer.cornerRadius = imageSize / 2.0
        profileImageView.clipsToBounds = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        title.text = ""
        title.isHidden = false
        desc.isHidden = false
        desc.text = ""
        location.text = ""
        createdat.text = ""
        userName.text = ""
        profileImageView.alpha = 0
        profileImageView.isShimmering = true
        commentCount.text = ""
    }
}
