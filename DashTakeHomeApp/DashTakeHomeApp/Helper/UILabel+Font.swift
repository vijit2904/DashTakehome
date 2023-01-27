//
//  UILabel+Font.swift
//  DashTakeHomeApp
//
//  Created by Vijit Munjal on 1/25/23.
//

import Foundation

import UIKit
extension UILabel {
    static func lableWith(_ size: CGFloat = 16, weight: UIFont.Weight = .light) -> UILabel {
       let lbl = UILabel()
       lbl.font = UIFont.systemFont(ofSize: size, weight: weight)
       lbl.textColor = .label
        return lbl
    }
}

extension UILabel {
    static func lableWithPreferredFont(for textStyle: UIFont.TextStyle) -> UILabel {
       let lbl = UILabel()
       lbl.font = UIFont.preferredFont(forTextStyle: textStyle)
       lbl.textColor = .label
        return lbl
    }
}
