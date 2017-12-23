//
//  main.swift
//  8080-emulator
//
//  Created by Christopher Oldfield on 12/23/17.
//  Copyright © 2017 humantree. All rights reserved.
//

import Foundation

let byteSize = MemoryLayout<UInt8>.size

struct ConditionBits {
  var carry = false
  var auxiliaryCarry = false
  var sign = false
  var zero = false
  var parity = false

}

struct Registers {
  var b = UInt8()
  var c = UInt8()
  var d = UInt8()
  var e = UInt8()
  var h = UInt8()
  var l = UInt8()
  var a = UInt8()
}

var conditionBits = ConditionBits()
var registers = Registers()

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

var registerPairs = RegisterPairs()

var memory = Data()
var programCounter = UInt16()
var stackPointer = UInt16()

func unimplementedInstruction(instruction: UInt8) {
  let hex = String(format: "%02X", instruction)
  print("Error: Unimplemented instruction (\(hex))")
  exit(1)
}

func nop() { programCounter += 1 }

// Dummy memory value for testing
memory = Data(bytes: [0x00])

while true {
  let range = NSRange(location: Int(programCounter), length: byteSize)
  let byteData = memory.subdata(in: Range(range)!) as NSData

  var byte = UInt8()
  byteData.getBytes(&byte, length: byteData.length)

  switch byte {
  case 0x00: nop()
  case 0x01: unimplementedInstruction(instruction: byte)
  case 0x02: unimplementedInstruction(instruction: byte)
  case 0x03: unimplementedInstruction(instruction: byte)
  case 0x04: unimplementedInstruction(instruction: byte)
  case 0x05: unimplementedInstruction(instruction: byte)
  case 0x06: unimplementedInstruction(instruction: byte)
  case 0x07: unimplementedInstruction(instruction: byte)
  case 0x08: nop()
  case 0x09: unimplementedInstruction(instruction: byte)
  case 0x0A: unimplementedInstruction(instruction: byte)
  case 0x0B: unimplementedInstruction(instruction: byte)
  case 0x0C: unimplementedInstruction(instruction: byte)
  case 0x0D: unimplementedInstruction(instruction: byte)
  case 0x0E: unimplementedInstruction(instruction: byte)
  case 0x0F: unimplementedInstruction(instruction: byte)
  case 0x10: nop()
  case 0x11: unimplementedInstruction(instruction: byte)
  case 0x12: unimplementedInstruction(instruction: byte)
  case 0x13: unimplementedInstruction(instruction: byte)
  case 0x14: unimplementedInstruction(instruction: byte)
  case 0x15: unimplementedInstruction(instruction: byte)
  case 0x16: unimplementedInstruction(instruction: byte)
  case 0x17: unimplementedInstruction(instruction: byte)
  case 0x18: nop()
  case 0x19: unimplementedInstruction(instruction: byte)
  case 0x1A: unimplementedInstruction(instruction: byte)
  case 0x1B: unimplementedInstruction(instruction: byte)
  case 0x1C: unimplementedInstruction(instruction: byte)
  case 0x1D: unimplementedInstruction(instruction: byte)
  case 0x1E: unimplementedInstruction(instruction: byte)
  case 0x1F: unimplementedInstruction(instruction: byte)
  case 0x20: unimplementedInstruction(instruction: byte)
  case 0x21: unimplementedInstruction(instruction: byte)
  case 0x22: unimplementedInstruction(instruction: byte)
  case 0x23: unimplementedInstruction(instruction: byte)
  case 0x24: unimplementedInstruction(instruction: byte)
  case 0x25: unimplementedInstruction(instruction: byte)
  case 0x26: unimplementedInstruction(instruction: byte)
  case 0x27: unimplementedInstruction(instruction: byte)
  case 0x28: nop()
  case 0x29: unimplementedInstruction(instruction: byte)
  case 0x2A: unimplementedInstruction(instruction: byte)
  case 0x2B: unimplementedInstruction(instruction: byte)
  case 0x2C: unimplementedInstruction(instruction: byte)
  case 0x2D: unimplementedInstruction(instruction: byte)
  case 0x2E: unimplementedInstruction(instruction: byte)
  case 0x2F: unimplementedInstruction(instruction: byte)
  case 0x30: unimplementedInstruction(instruction: byte)
  case 0x31: unimplementedInstruction(instruction: byte)
  case 0x32: unimplementedInstruction(instruction: byte)
  case 0x33: unimplementedInstruction(instruction: byte)
  case 0x34: unimplementedInstruction(instruction: byte)
  case 0x35: unimplementedInstruction(instruction: byte)
  case 0x36: unimplementedInstruction(instruction: byte)
  case 0x37: unimplementedInstruction(instruction: byte)
  case 0x38: nop()
  case 0x39: unimplementedInstruction(instruction: byte)
  case 0x3A: unimplementedInstruction(instruction: byte)
  case 0x3B: unimplementedInstruction(instruction: byte)
  case 0x3C: unimplementedInstruction(instruction: byte)
  case 0x3D: unimplementedInstruction(instruction: byte)
  case 0x3E: unimplementedInstruction(instruction: byte)
  case 0x3F: unimplementedInstruction(instruction: byte)
  case 0x40: unimplementedInstruction(instruction: byte)
  case 0x41: unimplementedInstruction(instruction: byte)
  case 0x42: unimplementedInstruction(instruction: byte)
  case 0x43: unimplementedInstruction(instruction: byte)
  case 0x44: unimplementedInstruction(instruction: byte)
  case 0x45: unimplementedInstruction(instruction: byte)
  case 0x46: unimplementedInstruction(instruction: byte)
  case 0x47: unimplementedInstruction(instruction: byte)
  case 0x48: unimplementedInstruction(instruction: byte)
  case 0x49: unimplementedInstruction(instruction: byte)
  case 0x4A: unimplementedInstruction(instruction: byte)
  case 0x4B: unimplementedInstruction(instruction: byte)
  case 0x4C: unimplementedInstruction(instruction: byte)
  case 0x4D: unimplementedInstruction(instruction: byte)
  case 0x4E: unimplementedInstruction(instruction: byte)
  case 0x4F: unimplementedInstruction(instruction: byte)
  case 0x50: unimplementedInstruction(instruction: byte)
  case 0x51: unimplementedInstruction(instruction: byte)
  case 0x52: unimplementedInstruction(instruction: byte)
  case 0x53: unimplementedInstruction(instruction: byte)
  case 0x54: unimplementedInstruction(instruction: byte)
  case 0x55: unimplementedInstruction(instruction: byte)
  case 0x56: unimplementedInstruction(instruction: byte)
  case 0x57: unimplementedInstruction(instruction: byte)
  case 0x58: unimplementedInstruction(instruction: byte)
  case 0x59: unimplementedInstruction(instruction: byte)
  case 0x5A: unimplementedInstruction(instruction: byte)
  case 0x5B: unimplementedInstruction(instruction: byte)
  case 0x5C: unimplementedInstruction(instruction: byte)
  case 0x5D: unimplementedInstruction(instruction: byte)
  case 0x5E: unimplementedInstruction(instruction: byte)
  case 0x5F: unimplementedInstruction(instruction: byte)
  case 0x60: unimplementedInstruction(instruction: byte)
  case 0x61: unimplementedInstruction(instruction: byte)
  case 0x62: unimplementedInstruction(instruction: byte)
  case 0x63: unimplementedInstruction(instruction: byte)
  case 0x64: unimplementedInstruction(instruction: byte)
  case 0x65: unimplementedInstruction(instruction: byte)
  case 0x66: unimplementedInstruction(instruction: byte)
  case 0x67: unimplementedInstruction(instruction: byte)
  case 0x68: unimplementedInstruction(instruction: byte)
  case 0x69: unimplementedInstruction(instruction: byte)
  case 0x6A: unimplementedInstruction(instruction: byte)
  case 0x6B: unimplementedInstruction(instruction: byte)
  case 0x6C: unimplementedInstruction(instruction: byte)
  case 0x6D: unimplementedInstruction(instruction: byte)
  case 0x6E: unimplementedInstruction(instruction: byte)
  case 0x6F: unimplementedInstruction(instruction: byte)
  case 0x70: unimplementedInstruction(instruction: byte)
  case 0x71: unimplementedInstruction(instruction: byte)
  case 0x72: unimplementedInstruction(instruction: byte)
  case 0x73: unimplementedInstruction(instruction: byte)
  case 0x74: unimplementedInstruction(instruction: byte)
  case 0x75: unimplementedInstruction(instruction: byte)
  case 0x76: unimplementedInstruction(instruction: byte)
  case 0x77: unimplementedInstruction(instruction: byte)
  case 0x78: unimplementedInstruction(instruction: byte)
  case 0x79: unimplementedInstruction(instruction: byte)
  case 0x7A: unimplementedInstruction(instruction: byte)
  case 0x7B: unimplementedInstruction(instruction: byte)
  case 0x7C: unimplementedInstruction(instruction: byte)
  case 0x7D: unimplementedInstruction(instruction: byte)
  case 0x7E: unimplementedInstruction(instruction: byte)
  case 0x7F: unimplementedInstruction(instruction: byte)
  case 0x80: unimplementedInstruction(instruction: byte)
  case 0x81: unimplementedInstruction(instruction: byte)
  case 0x82: unimplementedInstruction(instruction: byte)
  case 0x83: unimplementedInstruction(instruction: byte)
  case 0x84: unimplementedInstruction(instruction: byte)
  case 0x85: unimplementedInstruction(instruction: byte)
  case 0x86: unimplementedInstruction(instruction: byte)
  case 0x87: unimplementedInstruction(instruction: byte)
  case 0x88: unimplementedInstruction(instruction: byte)
  case 0x89: unimplementedInstruction(instruction: byte)
  case 0x8A: unimplementedInstruction(instruction: byte)
  case 0x8B: unimplementedInstruction(instruction: byte)
  case 0x8C: unimplementedInstruction(instruction: byte)
  case 0x8D: unimplementedInstruction(instruction: byte)
  case 0x8E: unimplementedInstruction(instruction: byte)
  case 0x8F: unimplementedInstruction(instruction: byte)
  case 0x90: unimplementedInstruction(instruction: byte)
  case 0x91: unimplementedInstruction(instruction: byte)
  case 0x92: unimplementedInstruction(instruction: byte)
  case 0x93: unimplementedInstruction(instruction: byte)
  case 0x94: unimplementedInstruction(instruction: byte)
  case 0x95: unimplementedInstruction(instruction: byte)
  case 0x96: unimplementedInstruction(instruction: byte)
  case 0x97: unimplementedInstruction(instruction: byte)
  case 0x98: unimplementedInstruction(instruction: byte)
  case 0x99: unimplementedInstruction(instruction: byte)
  case 0x9A: unimplementedInstruction(instruction: byte)
  case 0x9B: unimplementedInstruction(instruction: byte)
  case 0x9C: unimplementedInstruction(instruction: byte)
  case 0x9D: unimplementedInstruction(instruction: byte)
  case 0x9E: unimplementedInstruction(instruction: byte)
  case 0x9F: unimplementedInstruction(instruction: byte)
  case 0xA0: unimplementedInstruction(instruction: byte)
  case 0xA1: unimplementedInstruction(instruction: byte)
  case 0xA2: unimplementedInstruction(instruction: byte)
  case 0xA3: unimplementedInstruction(instruction: byte)
  case 0xA4: unimplementedInstruction(instruction: byte)
  case 0xA5: unimplementedInstruction(instruction: byte)
  case 0xA6: unimplementedInstruction(instruction: byte)
  case 0xA7: unimplementedInstruction(instruction: byte)
  case 0xA8: unimplementedInstruction(instruction: byte)
  case 0xA9: unimplementedInstruction(instruction: byte)
  case 0xAA: unimplementedInstruction(instruction: byte)
  case 0xAB: unimplementedInstruction(instruction: byte)
  case 0xAC: unimplementedInstruction(instruction: byte)
  case 0xAD: unimplementedInstruction(instruction: byte)
  case 0xAE: unimplementedInstruction(instruction: byte)
  case 0xAF: unimplementedInstruction(instruction: byte)
  case 0xB0: unimplementedInstruction(instruction: byte)
  case 0xB1: unimplementedInstruction(instruction: byte)
  case 0xB2: unimplementedInstruction(instruction: byte)
  case 0xB3: unimplementedInstruction(instruction: byte)
  case 0xB4: unimplementedInstruction(instruction: byte)
  case 0xB5: unimplementedInstruction(instruction: byte)
  case 0xB6: unimplementedInstruction(instruction: byte)
  case 0xB7: unimplementedInstruction(instruction: byte)
  case 0xB8: unimplementedInstruction(instruction: byte)
  case 0xB9: unimplementedInstruction(instruction: byte)
  case 0xBA: unimplementedInstruction(instruction: byte)
  case 0xBB: unimplementedInstruction(instruction: byte)
  case 0xBC: unimplementedInstruction(instruction: byte)
  case 0xBD: unimplementedInstruction(instruction: byte)
  case 0xBE: unimplementedInstruction(instruction: byte)
  case 0xBF: unimplementedInstruction(instruction: byte)
  case 0xC0: unimplementedInstruction(instruction: byte)
  case 0xC1: unimplementedInstruction(instruction: byte)
  case 0xC2: unimplementedInstruction(instruction: byte)
  case 0xC3: unimplementedInstruction(instruction: byte)
  case 0xC4: unimplementedInstruction(instruction: byte)
  case 0xC5: unimplementedInstruction(instruction: byte)
  case 0xC6: unimplementedInstruction(instruction: byte)
  case 0xC7: unimplementedInstruction(instruction: byte)
  case 0xC8: unimplementedInstruction(instruction: byte)
  case 0xC9: unimplementedInstruction(instruction: byte)
  case 0xCA: unimplementedInstruction(instruction: byte)
  case 0xCB: nop()
  case 0xCC: unimplementedInstruction(instruction: byte)
  case 0xCD: unimplementedInstruction(instruction: byte)
  case 0xCE: unimplementedInstruction(instruction: byte)
  case 0xCF: unimplementedInstruction(instruction: byte)
  case 0xD0: unimplementedInstruction(instruction: byte)
  case 0xD1: unimplementedInstruction(instruction: byte)
  case 0xD2: unimplementedInstruction(instruction: byte)
  case 0xD3: unimplementedInstruction(instruction: byte)
  case 0xD4: unimplementedInstruction(instruction: byte)
  case 0xD5: unimplementedInstruction(instruction: byte)
  case 0xD6: unimplementedInstruction(instruction: byte)
  case 0xD7: unimplementedInstruction(instruction: byte)
  case 0xD8: unimplementedInstruction(instruction: byte)
  case 0xD9: nop()
  case 0xDA: unimplementedInstruction(instruction: byte)
  case 0xDB: unimplementedInstruction(instruction: byte)
  case 0xDC: unimplementedInstruction(instruction: byte)
  case 0xDD: nop()
  case 0xDE: unimplementedInstruction(instruction: byte)
  case 0xDF: unimplementedInstruction(instruction: byte)
  case 0xE0: unimplementedInstruction(instruction: byte)
  case 0xE1: unimplementedInstruction(instruction: byte)
  case 0xE2: unimplementedInstruction(instruction: byte)
  case 0xE3: unimplementedInstruction(instruction: byte)
  case 0xE4: unimplementedInstruction(instruction: byte)
  case 0xE5: unimplementedInstruction(instruction: byte)
  case 0xE6: unimplementedInstruction(instruction: byte)
  case 0xE7: unimplementedInstruction(instruction: byte)
  case 0xE8: unimplementedInstruction(instruction: byte)
  case 0xE9: unimplementedInstruction(instruction: byte)
  case 0xEA: unimplementedInstruction(instruction: byte)
  case 0xEB: unimplementedInstruction(instruction: byte)
  case 0xEC: unimplementedInstruction(instruction: byte)
  case 0xED: nop()
  case 0xEE: unimplementedInstruction(instruction: byte)
  case 0xEF: unimplementedInstruction(instruction: byte)
  case 0xF0: unimplementedInstruction(instruction: byte)
  case 0xF1: unimplementedInstruction(instruction: byte)
  case 0xF2: unimplementedInstruction(instruction: byte)
  case 0xF3: unimplementedInstruction(instruction: byte)
  case 0xF4: unimplementedInstruction(instruction: byte)
  case 0xF5: unimplementedInstruction(instruction: byte)
  case 0xF6: unimplementedInstruction(instruction: byte)
  case 0xF7: unimplementedInstruction(instruction: byte)
  case 0xF8: unimplementedInstruction(instruction: byte)
  case 0xF9: unimplementedInstruction(instruction: byte)
  case 0xFA: unimplementedInstruction(instruction: byte)
  case 0xFB: unimplementedInstruction(instruction: byte)
  case 0xFC: unimplementedInstruction(instruction: byte)
  case 0xFD: nop()
  case 0xFE: unimplementedInstruction(instruction: byte)
  case 0xFF: unimplementedInstruction(instruction: byte)
  default: unimplementedInstruction(instruction: byte)
  }
}
