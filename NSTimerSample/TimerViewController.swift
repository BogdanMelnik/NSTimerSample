//
//  TimerViewController.swift
//  NSTimerSample
//
//  Created by Bogdan Melnik on 6/26/16.
//  Copyright © 2016 Yohoho. All rights reserved.
//

//
//  TimerViewController.swift
//  TimerButton
//
//  Created by Bogdan Melnik on 6/26/16.
//  Copyright © 2016 Yohoho. All rights reserved.
//

import UIKit

class TimerViewController: UIViewController {
    

    @IBOutlet weak var counterLabel: UILabel!
    @IBOutlet weak var recordImage: UIImageView!
    
    var timer: NSTimer!
    var counter: Double!
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.timer = NSTimer.init()
        self.counter = 0

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func playPause(sender: AnyObject) {
        if (self.timer?.valid==true){
            self.timer.invalidate()
            self.setPlayPauseSystemItem("play")
            self.setCounterLableColor("red")
            self.setRecordImageImage("red")
            self.recordImage.alpha = 1.0
            return
        }
        //self.timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: #selector(TimerViewController.updateCounter), userInfo: nil, repeats: true)
        self.timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(TimerViewController.updateCounter), userInfo: nil, repeats: true)
        self.setPlayPauseSystemItem("pause")
        self.setCounterLableColor("green")
        self.setRecordImageImage("green")
        self.recordImage.alpha = 1.0
    }
    
    @IBAction func stop(sender: AnyObject) {
        self.timer?.invalidate()
        self.counter = 0.0
        self.counterLabel.text = self.getNormalizedString(self.counter)
        self.setPlayPauseSystemItem("play")
        self.setCounterLableColor("red")
        self.setRecordImageImage("red")
        self.recordImage.alpha = 1.0
    }
    
    func updateCounter() {
        //self.counter = self.counter!+0.01
        self.counter = self.counter!+1
        self.counterLabel.text = self.getNormalizedString(self.counter)
        if(Int(self.counter % 2) == 0) {
            UIView.animateWithDuration(0.2, animations: {
                 self.recordImage.alpha = 1.0
                })
        } else {
            UIView.animateWithDuration(0.2, animations: {
                self.recordImage.alpha = 0.0
            })
        }
    }
    
    func setPlayPauseSystemItem(name: String) {
        if (name == "play") {
            let newPlayPause = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Play, target: self, action:  #selector(TimerViewController.playPause(_:)))
            self.navigationBar.topItem!.leftBarButtonItem = newPlayPause
            return
        }
        if (name == "pause") {
            let newPlayPause = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Pause, target: self, action:  #selector(TimerViewController.playPause(_:)))
            self.navigationBar.topItem!.leftBarButtonItem = newPlayPause
            return
        }
    }
    
    func setCounterLableColor(name: String)
    {
        if(name=="red"){
            self.counterLabel.textColor = UIColor.redColor()
            return
        }
        if(name=="green"){
            self.counterLabel.textColor = UIColor.greenColor()
            return
        }
    }
    
    func setRecordImageImage(name: String) {
        if(name=="red"){
            self.recordImage.image = UIImage(named: "record_red")
            return
        }
        if(name=="green"){
            self.recordImage.image = UIImage(named: "record_green")
            return
        }
    }
    
    func getNormalizedString(counter: Double) -> String {
        let interval = NSTimeInterval.init(counter)
        ()
        //return interval.minuteSecondMS
        return interval.hoursMinutesSeconds
        
    }
}

// Working wiht time representation
extension NSTimeInterval {
    
    var minuteSecondMS: String {
        return String(format:"%02d:%02d:%02d", self.minute, self.second, self.millisecond)
    }
    
    var hoursMinutesSeconds: String {
        return String(format:"%02d:%02d:%02d", self.hour, self.minute, self.second)
    }
    
    var hour: Int {
        return Int (self/3600)
    }
    
    var minute: Int {
        return Int(self/60.0 % 60)
    }
    var second: Int {
        return Int(self % 60)
    }
    var millisecond: Int {
        //return Int(self*1000 % 1000)
        return Int(self*1000 % 100)
    }
}

// Working wiht time representation
extension Int {
    var msToSeconds: Double {
        return Double(self) / 1000
    }
}

