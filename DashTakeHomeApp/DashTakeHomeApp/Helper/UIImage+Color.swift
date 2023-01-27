//
//  UIImage+Color.swift
//  DashTakeHomeApp
//
//  Created by Vijit Munjal on 1/27/23.
//

import UIKit

extension UIImage {
    static func make(withColor color: UIColor, width: CGFloat, height: CGFloat) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: width, height: height)
        let format = UIGraphicsImageRendererFormat()
        format.scale = 1
        return UIGraphicsImageRenderer(size: rect.size, format: format).image { renderContext in
            color.setFill()
            renderContext.fill(rect)
        }
    }
}
