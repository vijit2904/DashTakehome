//
//  XCTestCase+Helpers.swift
//  DashTakeHomeLibTests
//
//  Created by Vijit Munjal on 1/24/23.
//

import XCTest

extension XCTestCase {
    func trackMemoryLeakes(_ instance: AnyObject, file: StaticString = #filePath, line: UInt = #line) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(instance, "Instance should have been deallocated. Potentaial memory leak.",
                         file: file,
                         line: line)
        }
    }
}
