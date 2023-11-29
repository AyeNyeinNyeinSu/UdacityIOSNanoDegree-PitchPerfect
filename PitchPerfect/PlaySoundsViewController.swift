//
//  PlaySoundsViewController.swift
//  PitchPerfect
//
//  Created by Aye Nyein Nyein Su on 11/05/2023.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {

    @IBOutlet weak var rabbitButton: UIButton!
    @IBOutlet weak var snailButton: UIButton!
    @IBOutlet weak var chipmukButton: UIButton!
    @IBOutlet weak var vaderButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    var recordedAudioURL: URL!
    var audioFile:AVAudioFile!
    var audioEngine:AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!

    enum ButtonType: Int {
        case fast = 0, slow, chipmunk, vader, echo, reverb
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupAudio()
        configureUI(.notPlaying)        //stopButton disabled
    }
    
    @IBAction func playSoundForButton(_ sender: UIButton) {
        
        //print("Play Sound Button Pressed")
        switch(ButtonType(rawValue: sender.tag)!) {
           case .slow:
               playSound(rate: 0.5)
           case .fast:
               playSound(rate: 1.5)
           case .chipmunk:
               playSound(pitch: 1000)
           case .vader:
               playSound(pitch: -1000)
           case .echo:
               playSound(echo: true)
           case .reverb:
               playSound(reverb: true)
           }

           configureUI(.playing)
    }
    
    @IBAction func stopButtonPressed(_ sender: UIButton) {
        
        //print("Stop Audio Button Pressed")
        stopAudio()
    }
    
    
    


}
