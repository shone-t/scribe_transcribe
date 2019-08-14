//
//  ViewController.swift
//  Scribe
//
//  Created by MacBook Pro on 8/13/19.
//  Copyright © 2019 MacBook Pro. All rights reserved.
//

import UIKit
import Speech
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate {
    
    // Outlets
    @IBOutlet weak var activitySpinner: UIActivityIndicatorView!
    @IBOutlet weak var transciptionTextField: UITextView!
    
    // Varibale
    var audioPlayer: AVAudioPlayer!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        activitySpinner.isHidden = true
        
    }

    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        player.stop()
        activitySpinner.stopAnimating()
        activitySpinner.isHidden = true
    }
    
    func requestSpeechAuth() {
        SFSpeechRecognizer.requestAuthorization { (authStatus) in
            do {
                if authStatus == SFSpeechRecognizerAuthorizationStatus.authorized {
                    if let path = Bundle.main.url(forResource: "test", withExtension: "mp3") {
                        do {
                            let sound = try AVAudioPlayer(contentsOf: path)
                            self.audioPlayer = sound
                            self.audioPlayer.delegate = self
                            sound.play()
                        } catch {
                            print("-------- error: \(error.localizedDescription)")
                        }
                        
                        let recognizer = SFSpeechRecognizer()
                        let request = SFSpeechURLRecognitionRequest(url: path)
                        recognizer?.recognitionTask(with: request) { (result, error) in
                            if let error = error {
                                debugPrint("There was an error: \(error)")
                            } else {
                                //print(result?.bestTranscription.formattedString ?? "Nije uspeo")
                                self.transciptionTextField.text = result?.bestTranscription.formattedString
                            }
                            
                        }
                    }
                }
            } catch {
                print("--------GRESKA u do : \(error.localizedDescription)")
            }
            
        }
       
    }
    
    @IBAction func btnWasPressed(_ sender: Any) {
        activitySpinner.isHidden = false
        activitySpinner.startAnimating()
        requestSpeechAuth()
    }
    

}

