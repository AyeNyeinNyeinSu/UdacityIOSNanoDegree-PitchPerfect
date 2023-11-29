//
//  ViewController.swift
//  PitchPerfect
//
//  Created by Aye Nyein Nyein Su on 11/05/2023.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {

    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopRecordingButton: UIButton!
    
    var audioRecorder: AVAudioRecorder!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stopRecordingButton.isEnabled = false
    }

    @IBAction func recordAudio(_ sender: UIButton) {
    
        changeOutletInterface(label: "Recording in Progress...", startRecording: false, stopRecording: true)
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        //print(filePath!)
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSession.Category.playAndRecord, mode: AVAudioSession.Mode.default, options: AVAudioSession.CategoryOptions.defaultToSpeaker)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    @IBAction func stopRecording(_ sender: UIButton) {
  
       changeOutletInterface(label: "Tap to Record", startRecording: true, stopRecording: false)
        
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        } else {
            print("recording was not successful")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stopRecording" {
            let destinationVC = segue.destination as! PlaySoundsViewController
            let recordedAudioURL = sender as! URL
            destinationVC.recordedAudioURL = recordedAudioURL
        }
    }
    
    func changeOutletInterface(label: String, startRecording: Bool, stopRecording: Bool) {
       
        recordingLabel.text = label
        recordButton.isEnabled = startRecording
        stopRecordingButton.isEnabled = stopRecording 
    }
//suggestion
//    func setupUI(isRecording: Bool) {
//            recordingLabel.text = isRecording ? "Recording in Progress" : "Tap to record"
//            recordingButton.isEnabled = !isRecording
//            stopRecordingButton.isEnabled = isRecording
//    }
    
}

