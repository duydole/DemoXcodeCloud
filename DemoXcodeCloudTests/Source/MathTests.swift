//
//  MathTests.swift
//  DemoXcodeCloud
//
//  Created by Đỗ Lê Duy on 22/6/25.
//


import XCTest
@testable import DemoXcodeCloud
import Testing

@Suite("Math Calculator Tests")
struct MathTests {
    let calculator = MathCalculator()

    @Test("Add two positive numbers")
    func testAdd() async throws {
        #expect(calculator.add(2, 3) == 5, "2 + 3 should equal 5")
    }

    @Test("Add positive and negative numbers")
    func testAddWithNegative() async throws {
        #expect(calculator.add(5, -2) == 3, "5 + (-2) should equal 3")
    }

    @Test("Subtract two positive numbers")
    func testSubtract() async throws {
        #expect(calculator.subtract(5, 2) == 3, "5 - 2 should equal 3")
    }

    @Test("Subtract to get negative result")
    func testSubtractNegative() async throws {
        #expect(calculator.subtract(2, 5) == -3, "2 - 5 should equal -3")
    }

    @Test("Multiply two positive numbers")
    func testMultiply() async throws {
        #expect(calculator.multiply(4, 3) == 12, "4 * 3 should equal 12")
    }

    @Test("Multiply by zero")
    func testMultiplyByZero() async throws {
        #expect(calculator.multiply(10, 0) == 0, "10 * 0 should equal 0")
    }

    @Test("Divide two numbers")
    func testDivide() async throws {
        let result = try calculator.divide(10, 2)
        #expect(result == 5, "10 / 2 should equal 5")
    }

    @Test("Divide by zero throws error")
    func testDivideByZero() async throws {
        await #expect(throws: NSError.self) {
            try calculator.divide(10, 0)
        }
    }

    @Test("Power with positive exponent")
    func testPower() async throws {
        #expect(calculator.power(2, 3) == 8, "2^3 should equal 8")
    }

    @Test("Power with zero exponent")
    func testPowerZero() async throws {
        #expect(calculator.power(5, 0) == 1, "5^0 should equal 1")
    }
}
