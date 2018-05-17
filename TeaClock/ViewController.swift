//
//  ViewController.swift
//  TeaClock
//
//  Created by Florian Knaus on 5/16/18.
//  Copyright © 2018 Florian Knaus. All rights reserved.
//

import UIKit
import AVKit

class ViewController: UIViewController {
    
    let iDefaultMins: Int = 1;
    let iGreenTeaMins: Int = 2;
    let iBlackTeaMins: Int = 5;
    let iWhiteTeaMins: Int = 1;
    var secondsRemaining: Int = 0;
    let sStart: String = "Start"
    let sStop: String = "Stop"
    
    let bgTask: UIBackgroundTaskIdentifier = 0
    var tTimer: Timer = Timer()
    
    //MARK: Properties
    @IBOutlet weak var btnAction: UIButton!
    @IBOutlet weak var lblTimer: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        resetTimer(iMins: 0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func updateTimerLabel() {
        if secondsRemaining > 0 {
            secondsRemaining -= 1
            lblTimer.text = timeString(time: TimeInterval(secondsRemaining))
        } else {
            tTimer.invalidate()
            btnAction.setTitle(sStart, for: .normal)
            playAlarm()
        }
    }
    
    func playAlarm() {
        // play some alarm
        lblTimer.text = "Hooray, it worked!"
        let systemSoundId: SystemSoundID = 1016
        AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
        AudioServicesPlaySystemSound(systemSoundId)
    }
    
    func timeString(time: TimeInterval) -> String {
        let hours = Int(time) / (60 * 60)
        let mins = Int(time) / 60 % 60
        let secs = Int(time) % 60
        return String(format:"%02i:%02i:%02i", hours, mins, secs)
    }
    
    func resetTimer(iMins: Int) {
        secondsRemaining = iMins * 60
        lblTimer.text = timeString(time: TimeInterval(secondsRemaining))
        if btnAction.title(for: .normal) == sStop {
            tTimer.invalidate()
        }
        btnAction.setTitle(sStart, for: .normal)
    }
    
    func startTimer() {
        //start the timer
        tTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(ViewController.updateTimerLabel)), userInfo: nil, repeats: true)
    }
    
    func stopTimer() {
        tTimer.invalidate()
    }

    //MARK: Actions
    @IBAction func btnActionClick(_ sender: UIButton) {
        if btnAction.title(for: UIControlState.normal) == sStart {
            btnAction.setTitle(sStop, for: .normal)
            startTimer()
        } else {
            btnAction.setTitle(sStart, for: .normal)
            stopTimer()
        }
    }
    
    @IBAction func btnBlackTeaClick(_ sender: UIButton) {
        resetTimer(iMins: iBlackTeaMins)
    }
    @IBAction func btnGreenTeaClick(_ sender: UIButton) {
        resetTimer(iMins: iGreenTeaMins)
    }
    @IBAction func btnWhiteTeaClick(_ sender: UIButton) {
        resetTimer(iMins: iWhiteTeaMins)
    }
}

