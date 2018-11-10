//
//  MathFunctions.swift
//  SwissClock
//
//  Created by Mike Hill on 11/11/15.
//  Copyright © 2015 Mike Hill. All rights reserved.
//

import Foundation
import SpriteKit

func delay(_ delay:Double, closure:@escaping ()->()) {
    DispatchQueue.main.asyncAfter(
        deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
}

//extension NSString {
//    var FloatValue: Float {
//        #if os(iOS) || os(tvOS)
//        return self.floatValue
//        #endif
//        #if os(OSX)
//        return CGFloat(self.floatValue)
//        #endif
//    }
//}

class MathFunctions: NSObject {
    
    static func getQuadrant ( _ angleInRadians: Float ) -> Int {
        var quad = 0
        if (angleInRadians < Float( Double.pi/2) ) { quad = 1 }
        if (angleInRadians >= Float(Double.pi/2) && angleInRadians < Float(Double.pi) ) { quad = 2 }
        if (angleInRadians >= Float(Double.pi) && angleInRadians <= Float(Double.pi/2*3) ) { quad = 3 }
        if (angleInRadians > Float(Double.pi/2*3) && angleInRadians < Float(Double.pi*2) ) { quad = 4 }

        return quad
    }
    
#if os(OSX)
    
    static func rounder ( _ numToRound: Float, numPlaces: Float ) -> Float {
        let numberOfPlaces = 2.0
        let multiplier = Float( pow(10.0, numberOfPlaces) )
        let roundedNum = roundf( Float( numToRound ) * multiplier) / multiplier
        return Float ( roundedNum )
    }
    
#else
        static func rounder ( numToRound: Float, numPlaces: Float ) -> Float {
        let numberOfPlaces = 2.0
        let multiplier = Float( pow(10.0, numberOfPlaces) )
        let roundedNum = roundf(numToRound * multiplier) / multiplier
        return roundedNum
    }
#endif
    
    static func hourAngle(_ h:Int, m:Int) -> Float {
        let hAngle = Float(0.5) * (Float(h) * Float(60) + Float(m))
        
        return (hAngle)
    }
    
    static func timeAngle(_ m:Float) -> Float {
        let mAngle = Float(6.0) * Float(m)
        
        return (mAngle)
    }
    
    static func randomBetweenNumbers(_ firstNum: Float, secondNum: Float) -> Float{
        let absNum = Float(abs(firstNum - secondNum))
        let minNum = Float(min(firstNum, secondNum))
        return Float(arc4random()) / Float(UINT32_MAX) * absNum + minNum
    }
    
} 


