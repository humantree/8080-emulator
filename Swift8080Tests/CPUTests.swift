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
    memory = Data.init(repeating: 0x00, count: 0xFFFF)
    programCounter = Int()
    registers = Registers()
    stackPointer = UInt16()
  }

  func addToMemory(_ bytes: [UInt8]) {
    let data = Data.init(bytes: bytes)
    memory.replaceSubrange(0..<data.count, with: data)
  }

  func testACI() {
    addToMemory([
      0x3E, 0x56,
      0xCE, 0xBE,
      0xCE, 0x42])

    cpu.start()

    XCTAssertEqual(registers.a, 0x57)
    XCTAssertFalse(conditionBits.auxiliaryCarry)
    XCTAssertFalse(conditionBits.carry)
    XCTAssertFalse(conditionBits.parity)
    XCTAssertFalse(conditionBits.sign)
    XCTAssertFalse(conditionBits.zero)
  }

  func testADC1() {
    addToMemory([0x89])
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
    addToMemory([0x89])
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
    addToMemory([0x87])
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
    addToMemory([0x82])
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

  func testADI() {
    addToMemory([
      0x3E, 0x14,
      0xC6, 0x42,
      0xC6, 0xBE])

    cpu.start()

    XCTAssertEqual(registers.a, 0x14)
    XCTAssertTrue(conditionBits.auxiliaryCarry)
    XCTAssertTrue(conditionBits.carry)
    XCTAssertTrue(conditionBits.parity)
    XCTAssertFalse(conditionBits.sign)
    XCTAssertFalse(conditionBits.zero)
  }

  func testANA() {
    addToMemory([0xA1])
    registers.a = 0xFC
    registers.c = 0x0F

    cpu.start()

    XCTAssertEqual(registers.a, 0x0C)
    XCTAssertFalse(conditionBits.carry)
    XCTAssertTrue(conditionBits.parity)
    XCTAssertFalse(conditionBits.sign)
    XCTAssertFalse(conditionBits.zero)
  }

  func testCMA() {
    addToMemory([0x2F])
    registers.a = 0x51

    cpu.start()

    XCTAssertEqual(registers.a, 0xAE)
  }

  func testCMC() {
    addToMemory([0x3F])
    conditionBits.carry = true

    cpu.start()

    XCTAssertFalse(conditionBits.carry)
  }

  func testCMP1() {
    addToMemory([0xBB])
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
    addToMemory([0xBB])
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
    addToMemory([0xBB])
    registers.a = 0xE5
    registers.e = 0x05

    cpu.start()

    XCTAssertTrue(conditionBits.auxiliaryCarry)
    XCTAssertFalse(conditionBits.carry)
    XCTAssertFalse(conditionBits.parity)
    XCTAssertTrue(conditionBits.sign)
    XCTAssertFalse(conditionBits.zero)
  }

  func testDAA() {
    addToMemory([0x27])
    registers.a = 0x9B

    cpu.start()

    XCTAssertEqual(registers.a, 0x01)
    XCTAssertTrue(conditionBits.auxiliaryCarry)
    XCTAssertTrue(conditionBits.carry)
    XCTAssertFalse(conditionBits.parity)
    XCTAssertFalse(conditionBits.sign)
    XCTAssertFalse(conditionBits.zero)
  }

  func testDCR() {
    addToMemory([0x35])
    registers.h = 0x3A
    registers.l = 0x7C
    memory[0x3A7C] = 0x40

    cpu.start()

    XCTAssertEqual(memory[0x3A7C], 0x3F)
    XCTAssertFalse(conditionBits.auxiliaryCarry)
    XCTAssertTrue(conditionBits.parity)
    XCTAssertFalse(conditionBits.sign)
    XCTAssertFalse(conditionBits.zero)
  }

  func testINR() {
    addToMemory([0x0C])
    registers.c = 0x99

    cpu.start()

    XCTAssertEqual(registers.c, 0x9A)
    XCTAssertFalse(conditionBits.auxiliaryCarry)
    XCTAssertTrue(conditionBits.parity)
    XCTAssertTrue(conditionBits.sign)
    XCTAssertFalse(conditionBits.zero)
  }

  func testLDAX() {
    addToMemory([0x1A])
    memory[0x938B] = 0x2D
    registers.d = 0x93
    registers.e = 0x8B

    cpu.start()

    XCTAssertEqual(registers.a, 0x2D)
  }

  func testLXI1() {
    addToMemory([0x21, 0x03, 0x01])

    cpu.start()

    XCTAssertEqual(registers.h, 0x01)
    XCTAssertEqual(registers.l, 0x03)
  }

  func testLXI2() {
    addToMemory([0x31, 0xBC, 0x3A])

    cpu.start()

    XCTAssertEqual(stackPointer, 0x3ABC)
  }

  func testMOV() {
    addToMemory([0x77])
    registers.h = 0x2B
    registers.l = 0xE9
    registers.a = 0xEE

    cpu.start()

    XCTAssertEqual(memory[0x2BE9], 0xEE)
  }

  func testMVI() {
    addToMemory([
      0x26, 0x3C,
      0x2E, 0xF4,
      0x36, 0xFF])

    cpu.start()

    XCTAssertEqual(memory[0x3CF4], 0xFF)
  }

  func testNOP() {
    cpu.start()
  }

  func testORA() {
    addToMemory([0xB1])
    registers.c = 0x0F
    registers.a = 0x33

    cpu.start()

    XCTAssertEqual(registers.a, 0x3F)
    XCTAssertFalse(conditionBits.carry)
    XCTAssertTrue(conditionBits.parity)
    XCTAssertFalse(conditionBits.sign)
    XCTAssertFalse(conditionBits.zero)
  }

  func testPUSH1() {
    addToMemory([0xD5])
    registers.d = 0x8F
    registers.e = 0x9D
    stackPointer = 0x3A2C

    cpu.start()

    XCTAssertEqual(memory[0x3A2B], 0x8F)
    XCTAssertEqual(memory[0x3A2A], 0x9D)
    XCTAssertEqual(stackPointer, 0x3A2A)
  }

  func testPUSH2() {
    addToMemory([0xF5])
    registers.a = 0x1F
    stackPointer = 0x502A
    conditionBits.carry = true
    conditionBits.parity = true
    conditionBits.zero = true

    cpu.start()

    XCTAssertEqual(memory[0x5029], 0x1F)
    XCTAssertEqual(memory[0x5028], 0x47)
    XCTAssertEqual(stackPointer, 0x5028)
  }

  func testRAL() {
    addToMemory([0x17])
    registers.a = 0xB5

    cpu.start()

    XCTAssertEqual(registers.a, 0x6A)
    XCTAssertTrue(conditionBits.carry)
  }

  func testRAR() {
    addToMemory([0x1F])
    registers.a = 0x6A
    conditionBits.carry = true

    cpu.start()

    XCTAssertEqual(registers.a, 0xB5)
    XCTAssertFalse(conditionBits.carry)
  }
  
  func testRLC() {
    addToMemory([0x07])
    registers.a = 0xF2

    cpu.start()

    XCTAssertEqual(registers.a, 0xE5)
    XCTAssertTrue(conditionBits.carry)
  }

  func testRRC() {
    addToMemory([0x0F])
    registers.a = 0xF2

    cpu.start()

    XCTAssertEqual(registers.a, 0x79)
    XCTAssertFalse(conditionBits.carry)
  }

  func testSBB() {
    addToMemory([0x9D])
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

  func testSBI() {
    addToMemory([0xDE, 0x01])
    conditionBits.carry = true

    cpu.start()

    XCTAssertEqual(registers.a, 0xFE)
    XCTAssertFalse(conditionBits.auxiliaryCarry)
    XCTAssertTrue(conditionBits.carry)
    XCTAssertFalse(conditionBits.parity)
    XCTAssertTrue(conditionBits.sign)
    XCTAssertFalse(conditionBits.zero)
  }

  func testSTAX() {
    addToMemory([0x02])
    registers.a = 0x60
    registers.b = 0x3F
    registers.c = 0x16

    cpu.start()

    XCTAssertEqual(memory[0x3F16], 0x60)
  }

  func testSTC() {
    addToMemory([0x37])

    cpu.start()

    XCTAssertTrue(conditionBits.carry)
  }

  func testSUB() {
    addToMemory([0x97])
    registers.a = 0x3E

    cpu.start()

    XCTAssertEqual(registers.a, 0x00)
    XCTAssertTrue(conditionBits.auxiliaryCarry)
    XCTAssertFalse(conditionBits.carry)
    XCTAssertTrue(conditionBits.parity)
    XCTAssertFalse(conditionBits.sign)
    XCTAssertTrue(conditionBits.zero)
  }

  func testSUI() {
    addToMemory([
      0x3E, 0x00,
      0xD6, 0x01])

    cpu.start()

    XCTAssertEqual(registers.a, 0xFF)
    XCTAssertFalse(conditionBits.auxiliaryCarry)
    XCTAssertTrue(conditionBits.carry)
    XCTAssertTrue(conditionBits.parity)
    XCTAssertTrue(conditionBits.sign)
    XCTAssertFalse(conditionBits.zero)
  }

  func testXRA() {
    addToMemory([0xA8])
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
