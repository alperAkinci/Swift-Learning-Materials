//: Playground - noun: a place where people can play

import UIKit
import Foundation

public class PrivatePerson {
    private var firstName : String?
    private var lastName : String?
    
    public init(){}
    
    //providing initializer
    public init(firstName : String , lastName : String){
        self.firstName = firstName
        self.lastName = lastName
    }
    
    public func fullName() -> String{
        guard let fname = firstName else {
            
            return " "
        }
        
        guard let lname = lastName else {
            
            return " "
        }
        
        return "\(fname) \(lname)"
}
    
    public func changeFirstName(firstName : String){
        self.firstName = firstName
    }
    
}

