//
//  Helper.swift
//  DashTakeHomeApp
//
//  Created by Vijit Munjal on 1/27/23.
//

import Foundation

final class Helper {
    
    private init(){}
    
    static func needToloadMore(for indexPath: IndexPath, model count: Int) -> Bool {
        return (count - indexPath.row) <= 5
    }
    
    static func indexPathsForReload(intersecting indexPaths: [IndexPath],visibleRows paths: [IndexPath]) -> [IndexPath] {
        let visibleRows = paths
        let intersectingPaths = Set(visibleRows).intersection(indexPaths)
        return Array(intersectingPaths)
    }
    
    static func newIndexPaths(added itemsCount: Int, current count: Int) -> [IndexPath] {
        let startIndex = count - itemsCount
        let endIndexx  = startIndex + itemsCount
        return (startIndex..<endIndexx).map { IndexPath(row: $0, section: 0) }
    }
    
}
