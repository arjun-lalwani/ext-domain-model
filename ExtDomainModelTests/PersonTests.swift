//
//  PersonTests.swift
//  ExtDomainModel
//
//  Created by Arjun Lalwani on 18/10/16.
//  Copyright © 2016 Arjun Lalwani. All rights reserved.
//

import XCTest

class PersonTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testPerson() {
        
        let arjun = Person(firstName: "Arjun", lastName: "Lalwani", age: 19)
        arjun.job = Job(title: "Student", type: Job.JobType.Salary(1000))
        XCTAssert(arjun.description == "Arjun Lalwani, age: 19, job:Student Salary(1000))", arjun.description)
    }
    
}
