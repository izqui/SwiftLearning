// Playground - noun: a place where people can play

import UIKit
import QuartzCore

func polygon(sides n: Int!, radious r: Double!, color c: UIColor!) -> UIView {
    
    var points: CGPoint[] = CGPoint[](count: n, repeatedValue:CGPoint())
    points[0] = CGPoint(x: r, y:0)
    
    var calculations: Int = 0 //Number of points we have to find each side of the diameter
    
    if n % 2 == 0 {
        
        //If number of sides is even, place the one that is one diameter away
        points[Int(n / 2)] = CGPoint(x: r, y: 2*r)
        calculations = (n/2)-1
    }
    else {
        
        calculations = (n-1)/2
    }
    
    for i in 1...calculations{
        
        //Math stuff
        var lenght = 2.0*r*sin(Double(i)*M_PI/Double(n))
        var angle = M_PI/2 - (Double(i)*M_PI/Double(n))
        
        var x = lenght*sin(angle)
        var y = lenght*cos(angle)
        
        points[i] = CGPoint(x: r-x, y: y)
        points[n-i] = CGPoint(x: r+x, y: y)
        
    }
    
    var bp = UIBezierPath()
    
    bp.moveToPoint(points[0])
    for i in 0..points.count{
        bp.addLineToPoint(points[i])
    }
    bp.closePath()
    
    points
    bp
    
    let view = UIView()
    return view
}

polygon(sides: 11, radious: 100, color: UIColor.redColor())