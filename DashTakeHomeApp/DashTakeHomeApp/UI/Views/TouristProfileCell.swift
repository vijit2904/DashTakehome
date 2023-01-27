//
//  TouristProfileCell.swift
//  DashTakeHomeApp
//
//  Created by Vijit Munjal on 1/26/23.
//

import UIKit

class TouristProfileCell: UITableViewCell {
    
    lazy var name: UILabel = {
        let lbl = UILabel.lableWith()
        lbl.text = "Name:"
        return lbl
    }()
    
    lazy var nameTxt: UILabel = {
        return UILabel.lableWith()
    }()
    
    lazy var email: UILabel = {
        let lbl = UILabel.lableWith()
        lbl.text = "Email:"
        return lbl
    }()
    
    lazy var emailTxt: UILabel = {
        return UILabel.lableWith()
    }()
   
    lazy var loaction: UILabel = {
        let lbl = UILabel.lableWith()
        lbl.text = "Location:"
        return lbl
    }()
    
    lazy var loactionTxt: UILabel = {
        return UILabel.lableWith()
    }()
    
    lazy var memberSince: UILabel = {
        let lbl = UILabel.lableWith()
        lbl.text = "Member Since:"
        return lbl
    }()
    
    lazy var memberSinceTxt: UILabel = {
        return UILabel.lableWith()
    }()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setforMode()
        setView()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setforMode()
        setView()
    }
    
    private func setforMode() {
        self.contentView.backgroundColor = .systemBackground
        self.backgroundColor = .systemBackground
    }
    
    private func setView() {
        let nameSView = embedinHStack([name, nameTxt])
        let emailSView = embedinHStack([email, emailTxt])
        let locationSView = embedinHStack([loaction, loactionTxt])
        let memberSView = embedinHStack([memberSince, memberSinceTxt])
        let vStack = embedinVStack([nameSView, emailSView, locationSView, memberSView])
        addConstraint(for: vStack, contentView: contentView)
    }

}
