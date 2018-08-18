//
//  floatiosTests.swift
//  floatiosTests
//
//  Created by Alexander Skorulis on 29/6/18.
//  Copyright © 2018 Skorulis. All rights reserved.
//

import XCTest
import FLScene
@testable import floatios

class floatiosTests: XCTestCase {
    
    func testParticleLoading() {
        let b1 = Bundle.main
        let b2 = Bundle(for: Map3DScene.self)
        
        let p1 = b1.path(forResource: "teleporter", ofType: "scnp", inDirectory: nil)
        let p2 = b2.path(forResource: "teleporter", ofType: "scnp", inDirectory: "particles")
        
        XCTAssertNotNil(p1)
        XCTAssertNotNil(p2)
    }
}
