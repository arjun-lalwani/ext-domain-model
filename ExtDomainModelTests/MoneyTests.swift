//
//  MoneyTests.swift
//  ExtDomainModel
//
//  Created by Arjun Lalwani on 18/10/16.
//  Copyright © 2016 Arjun Lalwani. All rights reserved.
//

import XCTest

class MoneyTests: XCTestCase {
    
    let oneUSD = Money(amount: 1, currency: "USD")
    let tenUSD = Money(amount: 10, currency: "USD")
    let tenGBP = Money(amount: 10, currency: "GBP")
    let tenCAN = Money(amount: 10, currency: "CAN")
    let nineEUR = Money(amount: 9, currency: "EUR")
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testToString() {
        XCTAssert(oneUSD.description == "USD1.0")
        XCTAssert(tenUSD.description == "USD10.0")
        XCTAssert(tenGBP.description == "GBP10.0")
        XCTAssert(tenCAN.description == "CAN10.0")
        XCTAssert(nineEUR.description == "EUR9.0")
    }
    
    func testMathFunctions() {
        let addUSD = oneUSD.add(tenUSD)
        XCTAssert(addUSD.description == "USD11.0")
        
        let addUSDCAN = tenUSD.add(tenGBP.convert("USD"))
        XCTAssert(addUSDCAN.description == "USD30.0")
        
        let addUSDEUR = tenUSD.add(nineEUR.convert("USD"))
        XCTAssert(addUSDEUR.description == "USD16.0")
        
        let subUSD = tenUSD.subtract(tenUSD)
        XCTAssert(subUSD.description == "USD0.0")
        
        let subUSDGBP = (tenGBP.convert("USD")).subtract(tenUSD)
        XCTAssert(subUSDGBP.description == "USD10.0")
        
        let subUSDEUR = tenUSD.subtract(nineEUR.convert("USD"))
        XCTAssert(subUSDEUR.description == "USD4.0")
    }
    
    func testExtension() {
        XCTAssert(10.0.USD.description == "USD10.0")
        XCTAssert(10.0.GBP.description == "GBP10.0")
        XCTAssert(10.0.EUR.description == "EUR10.0")
        XCTAssert(10.0.CAN.description == "CAN10.0")
        XCTAssert(10.0.YEN.description == "YEN10.0")
    }

}
