//
//  ViewController.swift
//  SwiftLearning
//
//  Created by Jorge Izquierdo on 15/06/14.
//  Copyright (c) 2014 Jorge Izquierdo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var drawingView: UIView
    let initialRadious = 50.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Hola"
        drawingView.backgroundColor = UIColor.blackColor()
        
        var tapRecog = UITapGestureRecognizer(target: self, action: Selector("createShape:"))
        drawingView.userInteractionEnabled = true
        drawingView.addGestureRecognizer(tapRecog)
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createShape(sender: UITapGestureRecognizer){
        
        drawPolygon(point: sender.locationInView(drawingView))
    }
    
    func drawPolygon(point _point: CGPoint) {
        
        let p1 = PolygonView(sides: 3, radious: initialRadious)
        p1.frame.origin = CGPoint(x: _point.x+initialRadious, y: _point.y+initialRadious) //Calculate origin so the touch is the center of the polygon
        p1.backgroundColor = UIColor.cyanColor()
        drawingView.addSubview(p1)
    }
    
}

