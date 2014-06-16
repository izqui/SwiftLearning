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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Hola"
        drawingView.backgroundColor = UIColor.greenColor()
        
        drawPolygons()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func drawPolygons() {
        
        let p1 = PolygonView(sides: 5, radious: 100, color: UIColor.redColor(), orientation: .Regular)
        self.view.addSubview(p1)
        
    }
    
}

