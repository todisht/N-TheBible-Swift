//
//  ViewController.swift
//  N-TheBible
//
//  Created by Tim Todish on 10/7/14.
//  Copyright (c) 2014 Tim Todish. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var drawView: DrawView!
    @IBOutlet weak var closeButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func closePressed(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //shake to clear screen
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent) {
        if(event.subtype == UIEventSubtype.MotionShake) {
            drawView.lines = []
            drawView.setNeedsDisplay()
        }
    }
}

