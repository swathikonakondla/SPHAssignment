//
//  AssignmentTests.swift
//  AssignmentTests
//
//  Created by infinit on 4/8/19.
//  Copyright © 2019 SPH. All rights reserved.
//

import XCTest
import RealmSwift
@testable import Assignment

class AssignmentTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAPI() {
        let expectation = self.expectation(description: "Download data usage")
        var usageDetails = List<UsageDetail>()
        UsageDetailsServices.DownloadUsageDetails(usageDetails: usageDetails, offset: 0, limit: 25, resourceId: AppConstants.resourceId) { (status, message, usageResponse) in
            usageDetails = usageResponse
            assert(status == true)
            assert(usageDetails.count > 0)
            
            expectation.fulfill()
        }
        waitForExpectations(timeout: 30, handler: nil)
    }


    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
