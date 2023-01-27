//
//  UIView+Constraint.swift
//  DashTakeHomeApp
//
//  Created by Vijit Munjal on 1/25/23.
//

import UIKit

extension UIView {
    func addConstraint(for view: UIView, contentView: UIView, topbottomAnchor: CGFloat = 15.0, leadTralAnchor: CGFloat = 15.0 ) {
        contentView.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: leadTralAnchor),
            view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -leadTralAnchor),
            view.topAnchor.constraint(equalTo: contentView.topAnchor, constant: topbottomAnchor),
        ])
        let bottomAnchor = view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -topbottomAnchor)
        bottomAnchor.priority = UILayoutPriority(750)
        bottomAnchor.isActive = true
        let height = contentView.heightAnchor.constraint(equalToConstant: 0)
        height.priority = UILayoutPriority(255)
        height.isActive = true
    }
    
    
    func embedinHStack(_ views: [UIView], spacing: CGFloat = 5.0) -> UIStackView {
        let hStack = UIStackView()
        hStack.axis = .horizontal
        hStack.distribution = .equalCentering
        hStack.alignment = .center
        hStack.spacing = spacing
        views.forEach { subview in
            subview.translatesAutoresizingMaskIntoConstraints = false
            hStack.addArrangedSubview(subview) }
        return hStack
    }
    
    func embedinVStack(_ views: [UIView], spacing: CGFloat = 5.0) -> UIStackView {
        let vStack = UIStackView()
        vStack.axis = .vertical
        vStack.distribution = .equalCentering
        vStack.alignment = .leading
        vStack.spacing = spacing
        views.forEach { vStack.addArrangedSubview($0) }
        return vStack
    }
    
    
}
