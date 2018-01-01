//
//  CPUState.swift
//  Swift8080
//
//  Created by Christopher Oldfield on 12/24/17.
//  Copyright © 2017 humantree. All rights reserved.
//

import Foundation

var conditionBits = ConditionBits()
var memory = Data()
var programCounter = Int()
var registerPairs = RegisterPairs()
var registers = Registers()
var stackPointer = UInt16()

struct ConditionBits {
  var auxiliaryCarry = false
  var carry = false
  var parity = false
  var sign = false
  var zero = false

  mutating func setAuxiliaryCarry(_ nibbleResult: UInt8) {
    auxiliaryCarry = nibbleResult & 0x10 == 0x10
  }

  mutating func setCarry(_ result: UInt8, _ result16: UInt16) {
    carry = result16 != result
  }

  mutating func setParity(_ byte: UInt8) {
    var byte = byte
    var count = 0

    for _ in 0..<8 {
      if byte & 0x01 == 1 { count += 1 }
      byte >>= 1
    }

    parity = count % 2 == 0
  }

  mutating func setSign(_ byte: UInt8) {
    sign = byte & 0x80 != 0
  }

  mutating func setZero(_ byte: UInt8) {
    zero = byte == 0
  }
}

struct RegisterPairs {
  var b: (UInt8, UInt8) {
    get {
      return (registers.b, registers.c)
    }
    set {
      registers.b = newValue.0
      registers.c = newValue.1
    }
  }
  var d: (UInt8, UInt8) {
    get {
      return (registers.d, registers.e)
    }
    set {
      registers.d = newValue.0
      registers.e = newValue.1
    }
  }
  var h: (UInt8, UInt8) {
    get {
      return (registers.h, registers.l)
    }
    set {
      registers.h = newValue.0
      registers.l = newValue.1
    }
  }
  var psw: (UInt8, ConditionBits) {
    get {
      return (registers.a, conditionBits)
    }
    set {
      registers.a = newValue.0
      conditionBits = newValue.1
    }
  }
}

struct Registers {
  var b = UInt8()
  var c = UInt8()
  var d = UInt8()
  var e = UInt8()
  var h = UInt8()
  var l = UInt8()
  var a = UInt8()

  private var mAddress: Int {
    get { return Int(UInt16(self.h) << 8 + UInt16(self.l)) }
  }

  var m: UInt8 {
    get { return memory[mAddress] }
    set { memory[mAddress] = newValue }
  }
}
