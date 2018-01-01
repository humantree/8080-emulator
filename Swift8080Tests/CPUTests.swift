//
//  CPUTests.swift
//  Swift8080Tests
//
//  Created by Christopher Oldfield on 12/26/17.
//  Copyright © 2017 humantree. All rights reserved.
//

import XCTest
@testable import Swift8080

class CPUTests: XCTestCase {
  let cpu = CPU()

  override func setUp() {
    super.setUp()

    conditionBits = ConditionBits()
    memory = Data()
    programCounter = Int()
    registers = Registers()
    stackPointer = UInt16()
  }

  func testADC1() {
    memory = Data.init(bytes: [0x89])
    registers.c = 0x3D
    registers.a = 0x42

    cpu.start()

    XCTAssertEqual(registers.a, 0x7F)
    XCTAssertFalse(conditionBits.auxiliaryCarry)
    XCTAssertFalse(conditionBits.carry)
    XCTAssertFalse(conditionBits.parity)
    XCTAssertFalse(conditionBits.sign)
    XCTAssertFalse(conditionBits.zero)
  }

  func testADC2() {
    memory = Data.init(bytes: [0x89])
    registers.c = 0x3D
    registers.a = 0x42
    conditionBits.carry = true

    cpu.start()

    XCTAssertEqual(registers.a, 0x80)
    XCTAssertTrue(conditionBits.auxiliaryCarry)
    XCTAssertFalse(conditionBits.carry)
    XCTAssertFalse(conditionBits.parity)
    XCTAssertTrue(conditionBits.sign)
    XCTAssertFalse(conditionBits.zero)
  }

  func testADD1() {
    memory = Data.init(bytes: [0x87])
    registers.a = 0x0F

    cpu.start()

    XCTAssertEqual(registers.a, 0x1E)
    XCTAssertTrue(conditionBits.auxiliaryCarry)
    XCTAssertFalse(conditionBits.carry)
    XCTAssertTrue(conditionBits.parity)
    XCTAssertFalse(conditionBits.sign)
    XCTAssertFalse(conditionBits.zero)
  }

  func testADD2() {
    memory = Data.init(bytes: [0x82])
    registers.d = 0x2E
    registers.a = 0x6C

    cpu.start()

    XCTAssertEqual(registers.a, 0x9A)
    XCTAssertTrue(conditionBits.auxiliaryCarry)
    XCTAssertFalse(conditionBits.carry)
    XCTAssertTrue(conditionBits.parity)
    XCTAssertTrue(conditionBits.sign)
    XCTAssertFalse(conditionBits.zero)
  }

  func testANA() {
    memory = Data.init(bytes: [0xA1])
    registers.a = 0xFC
    registers.c = 0x0F

    cpu.start()

    XCTAssertEqual(registers.a, 0x0C)
    XCTAssertFalse(conditionBits.carry)
    XCTAssertTrue(conditionBits.parity)
    XCTAssertFalse(conditionBits.sign)
    XCTAssertFalse(conditionBits.zero)
  }

  func testCMP1() {
    memory = Data.init(bytes: [0xBB])
    registers.a = 0x0A
    registers.e = 0x05

    cpu.start()

    XCTAssertTrue(conditionBits.auxiliaryCarry)
    XCTAssertFalse(conditionBits.carry)
    XCTAssertTrue(conditionBits.parity)
    XCTAssertFalse(conditionBits.sign)
    XCTAssertFalse(conditionBits.zero)
  }

  func testCMP2() {
    memory = Data.init(bytes: [0xBB])
    registers.a = 0x02
    registers.e = 0x05

    cpu.start()

    XCTAssertFalse(conditionBits.auxiliaryCarry)
    XCTAssertTrue(conditionBits.carry)
    XCTAssertFalse(conditionBits.parity)
    XCTAssertTrue(conditionBits.sign)
    XCTAssertFalse(conditionBits.zero)
  }

  func testCMP3() {
    memory = Data.init(bytes: [0xBB])
    registers.a = 0xE5
    registers.e = 0x05

    cpu.start()

    XCTAssertTrue(conditionBits.auxiliaryCarry)
    XCTAssertFalse(conditionBits.carry)
    XCTAssertFalse(conditionBits.parity)
    XCTAssertTrue(conditionBits.sign)
    XCTAssertFalse(conditionBits.zero)
  }

  func testMVI() {
    memory = Data.init(repeating: 0x00, count: 0xFFFF)

    let data = Data.init(bytes: [
      0x26, 0x3C,
      0x2E, 0xF4,
      0x36, 0xFF])
    memory.replaceSubrange(0..<data.count, with: data)

    cpu.start()

    XCTAssertEqual(memory[0x3CF4], 0xFF)
  }

  func testNOP() {
    memory = Data.init(bytes: [0x00])
    cpu.start()
  }

  func testORA() {
    memory = Data.init(bytes: [0xB1])
    registers.c = 0x0F
    registers.a = 0x33

    cpu.start()

    XCTAssertEqual(registers.a, 0x3F)
    XCTAssertFalse(conditionBits.carry)
    XCTAssertTrue(conditionBits.parity)
    XCTAssertFalse(conditionBits.sign)
    XCTAssertFalse(conditionBits.zero)
  }

  func testRAL() {
    memory = Data.init(bytes: [0x17])
    registers.a = 0xB5

    cpu.start()

    XCTAssertEqual(registers.a, 0x6A)
    XCTAssertTrue(conditionBits.carry)
  }

  func testRAR() {
    memory = Data.init(bytes: [0x1F])
    registers.a = 0x6A
    conditionBits.carry = true

    cpu.start()

    XCTAssertEqual(registers.a, 0xB5)
    XCTAssertFalse(conditionBits.carry)
  }
  
  func testRLC() {
    memory = Data.init(bytes: [0x07])
    registers.a = 0xF2

    cpu.start()

    XCTAssertEqual(registers.a, 0xE5)
    XCTAssertTrue(conditionBits.carry)
  }

  func testRRC() {
    memory = Data.init(bytes: [0x0F])
    registers.a = 0xF2

    cpu.start()

    XCTAssertEqual(registers.a, 0x79)
    XCTAssertFalse(conditionBits.carry)
  }

  func testSBB() {
    memory = Data.init(bytes: [0x9D])
    registers.l = 0x02
    registers.a = 0x04
    conditionBits.carry = true

    cpu.start()

    XCTAssertEqual(registers.a, 0x01)
    XCTAssertTrue(conditionBits.auxiliaryCarry)
    XCTAssertFalse(conditionBits.carry)
    XCTAssertFalse(conditionBits.parity)
    XCTAssertFalse(conditionBits.sign)
    XCTAssertFalse(conditionBits.zero)
  }

  func testSUB() {
    memory = Data.init(bytes: [0x97])
    registers.a = 0x3E

    cpu.start()

    XCTAssertEqual(registers.a, 0x00)
    XCTAssertTrue(conditionBits.auxiliaryCarry)
    XCTAssertFalse(conditionBits.carry)
    XCTAssertTrue(conditionBits.parity)
    XCTAssertFalse(conditionBits.sign)
    XCTAssertTrue(conditionBits.zero)
  }

  func testXRA() {
    memory = Data.init(bytes: [0xA8])
    registers.a = 0x5C
    registers.b = 0x78

    cpu.start()

    XCTAssertEqual(registers.a, 0x24)
    XCTAssertFalse(conditionBits.auxiliaryCarry)
    XCTAssertFalse(conditionBits.carry)
    XCTAssertTrue(conditionBits.parity)
    XCTAssertFalse(conditionBits.sign)
    XCTAssertFalse(conditionBits.zero)
  }
}
