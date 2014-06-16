//
//  RandomColor.swift
//  SwiftLearning
//
//  Created by Jorge Izquierdo on 16/06/14.
//  Copyright (c) 2014 Jorge Izquierdo. All rights reserved.
//

import UIKit

extension UIColor {
    
    class func randomColor() -> UIColor! {
       
        var colors = [UIColor.redColor(), UIColor.cyanColor(), UIColor.blackColor(), UIColor.greenColor(), UIColor.blueColor(), UIColor.grayColor(), UIColor.yellowColor(), UIColor.orangeColor(), UIColor.magentaColor()]
        
        var r = Int(rand()) % Int(colors.count)
        
        return colors[r]
    }
}