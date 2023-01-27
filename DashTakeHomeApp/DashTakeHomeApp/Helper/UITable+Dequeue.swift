//
//  UITable+Dequeue.swift
//  DashTakeHomeApp
//
//  Created by Vijit Munjal on 1/25/23.
//

import UIKit

extension UITableView {
    func dequeueReusableCell<T: UITableViewCell>() -> T {
        let identifier = String(describing: T.self)
        return dequeueReusableCell(withIdentifier: identifier) as! T
    }
}

