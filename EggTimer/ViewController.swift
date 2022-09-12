//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2022 The App Brewery. All rights reserved.
//

import UIKit

import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var progessBar: UIProgressView!
    @IBOutlet weak var titleLabel: UILabel!
    
    let eggTimes = ["Soft": 3, "Medium": 4, "Hard": 7]
    var timer = Timer()
    var totalTime = 0
    var secondsPass = 0
    var player: AVAudioPlayer!
    
    @IBAction func hardenessSelected(_ sender: UIButton) {
        
        timer.invalidate()
        let hardeness = sender.currentTitle!
        totalTime = eggTimes[hardeness]!
        
        progessBar.progress = 0.0
        secondsPass = 0
        titleLabel.text = hardeness
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }
    
    @objc func updateCounter() {
        if secondsPass < totalTime {
            
            secondsPass += 1
            progessBar.progress = Float(secondsPass) / Float(totalTime)
            print(Float(secondsPass) / Float(totalTime))
            
        }else{
            timer.invalidate()
            titleLabel.text = "Listo!"
            
            let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
            player = try! AVAudioPlayer(contentsOf: url!)
            player.play()
        }
    }
}
