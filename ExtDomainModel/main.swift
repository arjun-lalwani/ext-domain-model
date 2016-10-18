//
//  main.swift
//  SimpleDomainModel
//
//  Created by Ted Neward on 4/6/16.
//  Copyright © 2016 Ted Neward. All rights reserved.
//

import Foundation

print("Hello, World!")

public func testMe() -> String {
    return "I have been tested"
}

open class TestMe {
    open func Please() -> String {
        return "I have been tested"
    }
}

protocol CustomStringConvertible {

    // this property should return a human-readable version of the contents
    var description: String { get }
    
}

protocol Mathematics {
    func add(_ to: Money) -> Money
    func subtract(_ from: Money) -> Money
}

extension Double {
    
    var USD: Money
    { return Money(amount: Int(self), currency: "USD") }
    var GBP: Money
    { return Money(amount: Int(self), currency: "GBP") }
    var EUR: Money
    { return Money(amount: Int(self), currency: "EUR") }
    var YEN: Money
    { return Money(amount: Int(self), currency: "YEN") }
    
}

////////////////////////////////////
// Money
//
// structs are passed by value, classes are passed by reference
// structs are much safer and bug free, structs should be used as defaults
// classes used only on special occasions
public struct Money: CustomStringConvertible, Mathematics{
    internal var description: String

    public var amount : Int
    public var currency : String
    
    init(amount: Int, currency: String) {
        
        self.amount = amount
        self.currency = currency
        self.description = "\(currency)\(Double(amount))"
    }
    
    public func convert(_ to: String) -> Money {
        
        if (self.currency == to) {
            
            return self
            
        } else {
            
            var sumAmounts: Int = 0
            if (self.currency == "GBP") {
                
                if (to == "USD") {
                    
                    sumAmounts = self.amount * 2
                    
                } else if (to == "EUR") {
                    
                    sumAmounts = self.amount * 3
                    
                } else if (to == "CAN") {
                    
                    sumAmounts = Int(Double(self.amount) * 2.5)
                }
                
            } else if (self.currency == "USD") {
                
                
                if (to == "GBP") {
                    
                    sumAmounts = Int(Double(self.amount) * 0.5)
                    
                } else if (to == "EUR") {
                    
                    sumAmounts = Int(Double(self.amount) * 1.5)
                    
                } else if (to == "CAN") {
                    
                    sumAmounts = Int(Double(self.amount) * 1.25)
                    
                }
                
            } else if (self.currency == "EUR") {
                
                if (to == "GBP") {
                    
                    sumAmounts = Int(Double(self.amount) / 3)
                    
                } else if (to == "CAN") {
                    
                    sumAmounts = Int(Double(self.amount) * (5 / 6))
                    
                } else if (to == "USD") {
                    
                    sumAmounts = Int(Double(self.amount) * (2 / 3))
                    
                }
                
            } else if (self.currency == "CAN") {
                
                if (to == "USD") {
                    
                    sumAmounts = Int(Double(self.amount) * (4 / 5))
                    
                } else if (to == "EUR") {
                    
                    sumAmounts = Int(Double(self.amount) * (3 / 2))
                    
                } else if (to == "GBP") {
                    
                    sumAmounts = Int(Double(self.amount) * (2 / 5))
                    
                }
            }
            
            return Money(amount: sumAmounts, currency: to) // self.currecny?
        }
        
    }
    
    public func add(_ to: Money) -> Money {
        
        if (self.currency == to.currency) {
            
            return Money(amount: self.amount + to.amount, currency: self.currency)
            
        } else {
            
            // converting currency of to: Money into self.currecny
            return to.add(self.convert(to.currency))
            
        }
        
    }
    
    public func subtract(_ from: Money) -> Money {
        
        if (self.currency == from.currency) {
            
            return Money(amount: self.amount - from.amount, currency: self.currency)
            
        } else {
            
            return from.subtract(self.convert(from.currency))
        }
        
    }
    
    ////////////////////////////////////
    // Job
    //
    open class Job : CustomStringConvertible {
        internal var description: String

        fileprivate var title : String
        fileprivate var type : JobType
        
        public enum JobType {
            case Hourly(Double)
            case Salary(Int)
        }
        
        public init(title : String, type : JobType) {
            self.title = title
            self.type = type
            self.description = "\(title) \(type))"
        }
        
        open func calculateIncome(_ hours: Int) -> Int {
            switch type {
            case .Hourly(let income) : return Int(income * Double(hours))
            case .Salary(let income) : return income
            }
        }
        
        // bumps up the salary by the passed percentage...
        open func raise(_ amt : Double) {
            switch type {
            case .Hourly(<#T##Double#>)
            }
        }
    }
    
    
    ////////////////////////////////////
    // Person
    //
    open class Person : CustomStringConvertible {
        internal var description: String

        open var firstName : String = ""
        open var lastName : String = ""
        open var age : Int = 0
        
        fileprivate var _job : Job? = nil
        // getters and setters for Job class
        open var job : Job? {
            get { return _job}
            set(value) {
                if (self.age > 15) {
                    _job = value
                }
            }
        }
        
        fileprivate var _spouse : Person? = nil
        open var spouse : Person? {
            get { return _spouse }
            set(value) {
                if (self.age > 17) {
                    _spouse =  value
                }
            }
        }
        
        public init(firstName : String, lastName: String, age : Int) {
            self.firstName = firstName
            self.lastName = lastName
            self.age = age
            self.description = "\(firstName) \(lastName) , age: \(age)"
            if (_job != nil) {
                self.description += " job: \(job)"
            }
            if (_spouse != nil) {
                self.description += " spouse: \(spouse)"
            }
        }
        
        open func toString() -> String {
            return "Person: firstName:\(firstName) lastName:\(lastName) age:\(age) job:\(_job) spouse:\(_spouse)"
            
        }
    }
    
    ////////////////////////////////////
    // Family
    //
    open class Family: CustomStringConvertible {
        internal var description: String

        fileprivate var members : [Person] = []
        
        public init(spouse1: Person, spouse2: Person) {
            
            if (spouse1.spouse == nil && spouse2.spouse == nil) {
                // adding to family of Person array
                members.append(spouse1)
                members.append(spouse2)
                spouse1.spouse = spouse2
                spouse2.spouse = spouse1
            }
            self.description = "spouse1 : \(spouse1) spouse2 : \(spouse2)"
        }
        
        open func haveChild(_ child: Person) -> Bool {
            
            for i in members {
                
                if (i.age > 21) {
                    members.append(child)
                    self.description += " child: \(child.description)"
                    return true
                }
            }
            return false
        }
        
        open func householdIncome() -> Int {
            return 1
        }
    }
}
