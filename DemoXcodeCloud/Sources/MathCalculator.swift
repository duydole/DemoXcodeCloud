//
//  MathCalculator.swift
//  DemoXcodeCloud
//
//  Created by Đỗ Lê Duy on 22/6/25.
//

import Foundation

class MathCalculator {
    func add(_ a: Int, _ b: Int) -> Int {
        return a + b
    }
    
    func subtract(_ a: Int, _ b: Int) -> Int {
        return a - b
    }
    
    func multiply(_ a: Int, _ b: Int) -> Int {
        return a * b
    }
    
    func divide(_ a: Int, _ b: Int) throws -> Int {
        guard b != 0 else {
            throw NSError(domain: "MathError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Division by zero"])
        }
        return a / b
    }
    
    func power(_ base: Int, _ exponent: Int) -> Int {
        guard exponent >= 0 else { return 1 }
        var result = 1
        for _ in 0..<exponent {
            result *= base
        }
        return result
    }
}
