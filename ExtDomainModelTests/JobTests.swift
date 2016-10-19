//
//  JobTests.swift
//  ExtDomainModel
//
//  Created by Arjun Lalwani on 18/10/16.
//  Copyright © 2016 Arjun Lalwani. All rights reserved.
//

import XCTest

class JobTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    let arjun = Job(title: "Student", type: Job.JobType.Salary(1000))
    
    let arjun2 = Job(title: "App Dev", type: Job.JobType.Hourly(500))
    
    
    func testDescription() {
        
        XCTAssert(arjun.description == "Student Salary(1000))")
        XCTAssert(arjun2.description == "App Dev Hourly(500.0))")
    }
    
    func testIncome() {
        
        XCTAssert(arjun2.calculateIncome(100) == 50000)
        XCTAssert(arjun.calculateIncome(100) == 1000)
        
    }
    
    func testRaise() {
        
        arjun.raise(1000)
        XCTAssert(arjun.calculateIncome(5) == 2000)
        
        arjun2.raise(100.0)
        XCTAssert(arjun2.calculateIncome(5) == 3000)
            
    }
}
