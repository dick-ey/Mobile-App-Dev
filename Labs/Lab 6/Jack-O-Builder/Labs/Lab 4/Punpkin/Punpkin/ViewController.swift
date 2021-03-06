//
//  ViewController.swift
//  Punpkin
//
//  Created by Matt Dickey on 10/13/15.
//  Copyright (c) 2015 Matt Dickey. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBAction func sliderMoved(sender: UISlider) {
        timer.invalidate()
        changeSliderValue()
    }
    
    @IBOutlet weak var pumpkinView: UIImageView!
    @IBOutlet weak var sliderOutlet: UISlider!
    @IBOutlet weak var sliderLabel: UILabel!
    
    
    var translation = CGPointMake(0.0, 0.0)
    var delta = CGPointMake(12, 4) // initilaize the delta to move 12 points laterally and 4 vertically
    var pumpRadius = CGFloat() // radius of image
    var timer = NSTimer() // make animation timer
    
    
    func moveImage() {
        
        let duration = Double(sliderOutlet.value)
        UIView.beginAnimations("pump", context: nil)
        UIView.animateWithDuration(duration, animations: {
            self.pumpkinView.transform = CGAffineTransformMakeTranslation(self.translation.x, self.translation.y)
            self.translation.x += self.delta.x
            self.translation.y += self.delta.y
        })
        
        UIView.commitAnimations()
        if pumpkinView.center.x + translation.x > view.bounds.size.width - pumpRadius || pumpkinView.center.x + translation.x < pumpRadius{
            delta.x = -delta.x
        }
        if pumpkinView.center.y + translation.y > view.bounds.size.height - pumpRadius || pumpkinView.center.y + translation.y < pumpRadius{
            delta.y = -delta.y
        }
    }

        func changeSliderValue() {
            sliderLabel.text = String(format: "%.2f", sliderOutlet.value * 100)
            timer = NSTimer.scheduledTimerWithTimeInterval(Double(sliderOutlet.value / 10), target: self, selector: "moveImage", userInfo: nil, repeats: true)
        }
    
    


   override func viewDidLoad() {
        pumpRadius = pumpkinView.frame.size.width/2
        changeSliderValue()
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

