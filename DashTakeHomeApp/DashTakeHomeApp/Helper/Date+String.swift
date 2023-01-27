//
//  Date+String.swift
//  DashTakeHomeApp
//
//  Created by Vijit Munjal on 1/25/23.
//

import Foundation

extension Date {
    func getStringDate(formmatter: String = "MMM dd, y") -> String {
        let dateFrommatter = DateFormatter()
        dateFrommatter.timeZone = .current
        dateFrommatter.dateFormat = formmatter
        return dateFrommatter.string(from: self)
    }
}
