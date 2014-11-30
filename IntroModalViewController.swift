//
//  IntroModalViewController.swift
//  N-TheBible
//
//  Created by Tim Todish on 10/8/14.
//  Copyright (c) 2014 Tim Todish. All rights reserved.
//

import UIKit
import MediaPlayer

protocol IntroModalDelegate{
    func introModalDidFinish(controller:IntroModalViewController)
}

class IntroModalViewController: UIViewController {
    
    @IBOutlet weak var btnClose: UIButton!
    @IBOutlet weak var btnVideo: UIImageView!
    
    
    var delegate:IntroModalDelegate! = nil
    let moviePlayerController = MPMoviePlayerController()
    
    
    @IBAction func closePressed(sender: UIButton) {
        //self.dismissViewControllerAnimated(true, completion: nil)
        delegate.introModalDidFinish(self)
    }
    
    
    @IBAction func playVideo(sender: AnyObject) {
        let fileURL = NSBundle.mainBundle().URLForResource("james", withExtension: "mp4")
        moviePlayerController.contentURL = fileURL
        
        //moviePlayerController.shouldAutoplay = false
        moviePlayerController.movieSourceType = MPMovieSourceType.File
        moviePlayerController.allowsAirPlay = true
        
        moviePlayerController.view.frame = CGRect(x: 76, y: 237, width: 498, height: 276)
        
        self.view.addSubview(moviePlayerController.view)
        
        moviePlayerController.prepareToPlay()
        moviePlayerController.play()
    }
    
    
}
