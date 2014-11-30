//
//  GospelPresoViewController.swift
//  N-TheBible
//
//  Created by Tim Todish on 10/26/14.
//  Copyright (c) 2014 Tim Todish. All rights reserved.
//

import UIKit
import Foundation

class GospelPresoViewController: UIViewController,IntroModalDelegate {
    
    let verses: [String] = ["Do you know what it says “N” the Bible about how to get to Heaven? Would you be able to share the good news with others? Become familiar with the gospel message with this memory tool!","A circle has no beginning and no end, and represents living forever with God in Heaven, and never dying. There will be no more pain, or sadness –only happiness with our Creator, our Friend!","All have sinned. (Romans 3:23)","Sin separates us from God. (Romans 6:23)","God sent Jesus to die and rise again for my sin! (1 Corinthians 15:3)","I can live forever with Jesus my friend! (John 3:16)","If you haven’t already, you can ask Jesus to forgive you and live “N” (in) you today!"]
    
    let screenSize: CGRect = UIScreen.mainScreen().bounds
    let verseLabel:UILabel = UILabel(frame: CGRect(x: 20, y: 20, width: 335, height: CGFloat.max))
    let verseHolder:UIView = UIView()
    let btnContinue:UIButton =  UIButton.buttonWithType(UIButtonType.System) as UIButton
    
    var verseNumber: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        verseHolder.backgroundColor = UIColor(red: 0.85, green: 0.24, blue: 0.18, alpha: 0.75)
        
        verseLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
        verseLabel.numberOfLines = 0
        verseLabel.font = UIFont(name: "systemFont", size: 14)
        verseLabel.textColor = UIColor.whiteColor()
        
        verseHolder.addSubview(verseLabel)
        
        self.view.addSubview(verseHolder)
        
        
        self.btnContinue.backgroundColor = UIColor(red: 0.9, green: 0.55, blue: 0.25, alpha: 0.85)
        self.btnContinue.frame = CGRect(x: self.screenSize.width, y: self.screenSize.height-70, width: 140, height: 44)
        self.btnContinue.setTitle("Continue >", forState: UIControlState.Normal)
        self.btnContinue.addTarget(self, action: "btnContinueHandler:", forControlEvents: UIControlEvents.TouchUpInside)
        self.btnContinue.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        self.view.addSubview(self.btnContinue)

    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        showIntroModal()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showIntroModal() {
        //if (!introModalDidDisplay) {
        let intro = self.storyboard?.instantiateViewControllerWithIdentifier("introModal") as IntroModalViewController
        intro.delegate = self
        intro.modalPresentationStyle = UIModalPresentationStyle.FormSheet
        self.presentViewController(intro, animated: true, completion: nil)
        //}
    }
    
    func btnContinueHandler(sender:UIButton!) {
        println("verse number: \(self.verseNumber)")
        drawStep()
    }
    
    //MARK: - Delegate methods
    func introModalDidFinish(controller: IntroModalViewController) {
        self.dismissViewControllerAnimated(true, completion: nil)
        drawStep()
    }
    

    
    func drawStep() {
       
        verseLabel.text = self.verses[self.verseNumber]
        verseLabel.frame = CGRect(x:15, y: 10, width: 320, height: 140)
        
        switch self.verseNumber {
        case 0:
            verseHolder.frame = CGRect(x: self.screenSize.width, y: 113, width: 360, height: 120)
            verseLabel.sizeToFit()
            
            UIView.animateWithDuration(0.4, delay: 0.2, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
                self.verseHolder.frame = CGRect(x: self.screenSize.width-self.verseHolder.frame.width, y: 113, width: self.verseHolder.frame.width, height: self.verseHolder.frame.height)
                }) { (Bool) -> Void in
                    println("step zero done.")
                    
                    UIView.animateWithDuration(0.4, delay: 0.4, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
                        self.btnContinue.frame = CGRect(x: self.screenSize.width-self.btnContinue.frame.width, y: self.screenSize.height-70, width: self.btnContinue.frame.width, height: self.btnContinue.frame.height)
                        }) { (Bool) -> Void in
                            println("complete")
                            self.verseNumber++
                    }
            }
        case 1:
            // set up some values to use in the curve
            let ovalStartAngle = CGFloat(90.01 * M_PI/180)
            let ovalEndAngle = CGFloat(90 * M_PI/180)
            let ovalRect = CGRectMake(68, 280, 647, 647)
            
            // create the bezier path
            let ovalPath = UIBezierPath()
            
            ovalPath.addArcWithCenter(CGPointMake(CGRectGetMidX(ovalRect), CGRectGetMidY(ovalRect)),
                radius: CGRectGetWidth(ovalRect) / 2,
                startAngle: ovalStartAngle,
                endAngle: ovalEndAngle, clockwise: true)
            
            // create an object that represents how the curve
            // should be presented on the screen
            let progressLine = CAShapeLayer()
            progressLine.path = ovalPath.CGPath
            progressLine.strokeColor = UIColor(red: 0.95, green: 0.54, blue: 0.2, alpha:1.0).CGColor
            progressLine.fillColor = UIColor.clearColor().CGColor
            progressLine.lineWidth = 14.0
            progressLine.lineCap = kCALineCapRound
            
            // add the curve to the screen
            self.view.layer.insertSublayer(progressLine, atIndex: 2)
            
            // create a basic animation that animates the value 'strokeEnd'
            let animateStrokeEnd = CABasicAnimation(keyPath: "strokeEnd")
            animateStrokeEnd.duration = 1.0
            animateStrokeEnd.fromValue = 0.0
            animateStrokeEnd.toValue = 1.0
            
            // add the animation
            progressLine.addAnimation(animateStrokeEnd, forKey: "animate stroke end animation")
            
            verseHolder.frame = CGRect(x: self.screenSize.width, y: 113, width: 360, height: 135)
            verseLabel.sizeToFit()
            
            UIView.animateWithDuration(0.4, delay: 0.2, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
                self.verseHolder.frame = CGRect(x: self.screenSize.width-self.verseHolder.frame.width, y: 113, width: self.verseHolder.frame.width, height: self.verseHolder.frame.height)
                }) { (Bool) -> Void in
                    println("step zero done.")
                }
            
            self.verseNumber++
        case 2:
            //draw first dot.
            drawDot(CGRectMake(180, 852, 50, 50),dotDelay: 0.0)
            
            verseHolder.frame = CGRect(x: self.screenSize.width, y: 113, width: 360, height: 40)
            verseLabel.sizeToFit()
            
            UIView.animateWithDuration(0.4, delay: 0.2, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
                self.verseHolder.frame = CGRect(x: self.screenSize.width-self.verseHolder.frame.width, y: 113, width: self.verseHolder.frame.width, height: self.verseHolder.frame.height)
                }) { (Bool) -> Void in
                    println("step zero done.")
            }
            
            self.verseNumber++
            
        case 3:
            var path = CGPathCreateMutable()
            CGPathMoveToPoint(path, nil, 205, 852)
            CGPathAddLineToPoint(path, nil, 205, 361)
            
            let progressLine2 = CAShapeLayer()
            progressLine2.path = path
            progressLine2.strokeColor = UIColor(red: 0.95, green: 0.54, blue: 0.2, alpha:1.0).CGColor
            progressLine2.fillColor = UIColor.clearColor().CGColor
            progressLine2.lineWidth = 14.0
            progressLine2.lineCap = kCALineCapRound
            
            // add the curve to the screen
            self.view.layer.addSublayer(progressLine2)
            
            // create a basic animation that animates the value 'strokeEnd'
            let animateStrokeEnd2 = CABasicAnimation(keyPath: "strokeEnd")
            animateStrokeEnd2.duration = 0.75
            animateStrokeEnd2.fromValue = 0.0
            animateStrokeEnd2.toValue = 1.0
            
            // add the animation
            progressLine2.addAnimation(animateStrokeEnd2, forKey: "animate stroke end animation")
            
            //Draw second dot.
            drawDot(CGRectMake(180, 311, 50, 50),dotDelay:0.75)
            
            
            verseHolder.frame = CGRect(x: self.screenSize.width, y: 113, width: 360, height: 65)
            verseLabel.sizeToFit()
            UIView.animateWithDuration(0.4, delay: 0.2, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
                self.verseHolder.frame = CGRect(x: self.screenSize.width-self.verseHolder.frame.width, y: 113, width: self.verseHolder.frame.width, height: self.verseHolder.frame.height)
                }) { (Bool) -> Void in
                    println("step zero done.")
            }
            
            self.verseNumber++
            
        case 4:
            var path = CGPathCreateMutable()
            CGPathMoveToPoint(path, nil, 215, 360)
            CGPathAddLineToPoint(path, nil, 545, 860)

            let progressLine2 = CAShapeLayer()
            progressLine2.path = path
            progressLine2.strokeColor = UIColor(red: 0.95, green: 0.54, blue: 0.2, alpha:1.0).CGColor
            progressLine2.fillColor = UIColor.clearColor().CGColor
            progressLine2.lineWidth = 14.0
            progressLine2.lineCap = kCALineCapRound

            // add the curve to the screen
            self.view.layer.addSublayer(progressLine2)

            // create a basic animation that animates the value 'strokeEnd'
            let animateStrokeEnd2 = CABasicAnimation(keyPath: "strokeEnd")
            animateStrokeEnd2.duration = 0.75
            animateStrokeEnd2.fromValue = 0.0
            animateStrokeEnd2.toValue = 1.0
            
            // add the animation
            progressLine2.addAnimation(animateStrokeEnd2, forKey: "animate stroke end animation")
            
            //draw third dot.
            drawDot(CGRectMake(534, 857, 50, 50), dotDelay: 0.75)
            
            verseHolder.frame = CGRect(x: self.screenSize.width, y: 113, width: 360, height: 75)
            verseLabel.sizeToFit()
            
            UIView.animateWithDuration(0.4, delay: 0.2, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
                self.verseHolder.frame = CGRect(x: self.screenSize.width-self.verseHolder.frame.width, y: 113, width: self.verseHolder.frame.width, height: self.verseHolder.frame.height)
                }) { (Bool) -> Void in
                    println("step zero done.")
            }
            
            self.verseNumber++
            
        case 5:
            var path = CGPathCreateMutable()
            CGPathMoveToPoint(path, nil, 559, 857)
            CGPathAddLineToPoint(path, nil, 559, 361)
            
            let progressLine2 = CAShapeLayer()
            progressLine2.path = path
            progressLine2.strokeColor = UIColor(red: 0.95, green: 0.54, blue: 0.2, alpha:1.0).CGColor
            progressLine2.fillColor = UIColor.clearColor().CGColor
            progressLine2.lineWidth = 14.0
            progressLine2.lineCap = kCALineCapRound
            
            // add the curve to the screen
            self.view.layer.addSublayer(progressLine2)
            
            // create a basic animation that animates the value 'strokeEnd'
            let animateStrokeEnd2 = CABasicAnimation(keyPath: "strokeEnd")
            animateStrokeEnd2.duration = 0.75
            animateStrokeEnd2.fromValue = 0.0
            animateStrokeEnd2.toValue = 1.0
            
            // add the animation
            progressLine2.addAnimation(animateStrokeEnd2, forKey: "animate stroke end animation")
            
            //draw fourth dot.
            drawDot(CGRectMake(534, 311, 50, 50), dotDelay: 0.75)
            
            verseHolder.frame = CGRect(x: self.screenSize.width, y: 113, width: 360, height: 75)
            verseLabel.sizeToFit()
            
            UIView.animateWithDuration(0.4, delay: 0.2, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
                self.verseHolder.frame = CGRect(x: self.screenSize.width-self.verseHolder.frame.width, y: 113, width: self.verseHolder.frame.width, height: self.verseHolder.frame.height)
                }) { (Bool) -> Void in
                    println("step zero done.")
            }
            
            self.verseNumber++
            
        case 6 :
            verseHolder.frame = CGRect(x: self.screenSize.width, y: 113, width: 360, height: 75)
            verseLabel.sizeToFit()
            
            UIView.animateWithDuration(0.4, delay: 0.2, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
                self.verseHolder.frame = CGRect(x: self.screenSize.width-self.verseHolder.frame.width, y: 113, width: self.verseHolder.frame.width, height: self.verseHolder.frame.height)
                }) { (Bool) -> Void in
                    println("step zero done.")
                    
                    UIView.animateWithDuration(0.4, delay: 0.4, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
                        self.btnContinue.frame = CGRect(x: self.screenSize.width, y: self.screenSize.height-70, width: self.btnContinue.frame.width, height: self.btnContinue.frame.height)
                        }) { (Bool) -> Void in
                            println("complete")
                    }
            }
        default :
            println("default case")
        }
    }
    
    func drawDot(dotRect:CGRect,dotDelay:Double){
        let ovalStartAngle = CGFloat(90.01 * M_PI/180)
        let ovalEndAngle = CGFloat(90 * M_PI/180)
        let ovalRect = dotRect

        // create the bezier path
        let ovalPath = UIBezierPath()

        ovalPath.addArcWithCenter(CGPointMake(CGRectGetMidX(ovalRect), CGRectGetMidY(ovalRect)),
            radius: CGRectGetWidth(ovalRect) / 2,
            startAngle: ovalStartAngle,
            endAngle: ovalEndAngle, clockwise: true)

        let progressLine = CAShapeLayer()
        progressLine.path = ovalPath.CGPath
        progressLine.strokeColor = UIColor(red: 0.95, green: 0.54, blue: 0.2, alpha:1.0).CGColor
        progressLine.fillColor = UIColor(red: 0.95, green: 0.54, blue: 0.2, alpha:1.0).CGColor
        progressLine.lineWidth = 1.0
        progressLine.lineCap = kCALineCapRound
        progressLine.beginTime = CACurrentMediaTime() + dotDelay
        
        // add the curve to the screen
        self.view.layer.addSublayer(progressLine)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
