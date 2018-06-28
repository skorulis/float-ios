//
//  MaxValueField.swift
//  Common
//
//  Created by Alexander Skorulis on 26/6/18.
//

public final class MaxValueField: Codable {

    public var value:Int
    public var maxValue:Int
    
    public init(maxValue:Int) {
        self.maxValue = maxValue
        self.value = maxValue
    }
    
    public func add(_ amount:Int) {
        self.value = min(self.value + amount,self.maxValue)
    }
    
    static func +=(left:MaxValueField,right:Int) {
        left.add(right)
    }
    
    static func -=(left:MaxValueField,right:Int) {
        left.add(-right)
    }
    
    
}