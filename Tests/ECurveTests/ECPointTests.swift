//
//  ECPointTests.swift
//  Crypto Coin Swift
//
//  Created by Sjors Provoost on 26-06-14.
//
//  Example domain from: https://github.com/cryptocoinjs/ecurve/blob/master/test/curve.js

import XCTest
import ECurve
import UInt256

class ECPointTests: XCTestCase {
    
    var field = FiniteField.PrimeField(p: 11)
    
    var curve = ECurve(field: FiniteField.PrimeField(p: 11), gX: FiniteField.PrimeField(p: 11).int(8), gY: FiniteField.PrimeField(p: 11).int(6), a: UInt256(1), b: UInt256(0), n: UInt256(12), h: nil)
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testInitWithG() {
        // Initialize the point G of a secp256k1 curve on itself.
        curve = ECurve(domain: .Secp256k1)
        
        let g = ECPoint(x: EllipticCurveDomain.Secp256k1.gX, y: EllipticCurveDomain.Secp256k1.gY, curve: curve)
        
        switch g.coordinate {
        case let .Affine(x, _):
            XCTAssertEqual(x!.value.toHexString, EllipticCurveDomain.Secp256k1.gX.value.toHexString, "Gx hex");
            XCTAssertTrue(x! == EllipticCurveDomain.Secp256k1.gX, "Gx equality");

        default:
            assert(false, "Not good")
        }
    }
    
    
//    func testInitWithCompressedPoint() {
//        let curve = ECurve(domain: .Secp256k1)
//        let x = UInt256(hexString: "79be667ef9dcbbac55a06295ce870b07029bfcdb2dce28d959f2815b16f81798")
//        let y = UInt256(hexString: "483ada7726a3c4655da4fbfc0e1108a8fd17b448a68554199c47d08ffb10d4b8")
//        
//        let a:ECPoint = ECPoint(x: x, y: y, curve: curve)
//
//        let b:ECPoint = ECPoint(compressedPointHexString: "0279BE667EF9DCBBAC55A06295CE870B07029BFCDB2DCE28D959F2815B16F81798", curve: curve)
//        
//        XCTAssertTrue(a == b, "Decompress point");
//    }
    
    func testInitWithInfinity() {
        let a = curve.infinity
        
        XCTAssertTrue(a.isInfinity, "and beyond!")
    }
    
    func testInitWithSubscript() {
        _ = curve[5,8]
    }
    
    func testConvertToJacobian() {
        var p = curve[5,8]
        p.convertToJacobian()
        
        switch p.coordinate {
        case let .Jacobian(X,Y,Z):
            XCTAssertEqual(X,field.int(5), X.description);
            XCTAssertEqual(Y,field.int(8), Y.description);
            XCTAssertEqual(Z,field.int(1), Z.description);
        default:
            XCTAssertTrue(false, "Expected a Jacobian coordinate")
        }
    }
    
    func testConvertToAffine() {
        var p = curve[5,8]
        p.convertToJacobian()

        // Trivial conversion:
        p.convertToAffine()
        
        switch p.coordinate {
        case let .Affine(x,y):
            XCTAssertEqual(x!,field.int(5), x!.description);
            XCTAssertEqual(y!,field.int(8), y!.description);
        default:
            XCTAssertTrue(false, "Expected a Jacobian coordinate")
        }
        
        // Non trivial conversion
        p = ECPoint(coordinate: .Jacobian(X: field.int(9) , Y: field.int(9), Z: field.int(2)), curve: curve)
        p.convertToAffine()
        
        switch p.coordinate {
        case let .Affine(x,y):
            XCTAssertEqual(x!,field.int(5), x!.description);
            XCTAssertEqual(y!,field.int(8), y!.description);
        default:
            XCTAssertTrue(false, "Expected a Jacobian coordinate")
        }

    }

}
