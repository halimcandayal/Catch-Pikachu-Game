//
//  ViewController.swift
//  CatchThePikachuGame
//
//  Created by Halimcan Dayal on 2.03.2022.
//

import UIKit

class ViewController: UIViewController {
    
    
    //Veriables
    var score = 0
    var timer = Timer()
    var counter = 0
    var pikachuArray = [UIImageView]()
    var hideTimer = Timer()
    var highScore = 0
    
    
    //Views
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highscoreLabel: UILabel!
    @IBOutlet weak var pikachu1: UIImageView!
    @IBOutlet weak var pikachu2: UIImageView!
    @IBOutlet weak var pikachu3: UIImageView!
    @IBOutlet weak var pikachu4: UIImageView!
    @IBOutlet weak var pikachu5: UIImageView!
    @IBOutlet weak var pikachu6: UIImageView!
    @IBOutlet weak var pikachu7: UIImageView!
    @IBOutlet weak var pikachu8: UIImageView!
    @IBOutlet weak var pikachu9: UIImageView!
    
    
override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    
    scoreLabel.text = "Score: \(score)"
    
    //Highscore check
    
    let storedHighScore = UserDefaults.standard.object(forKey: "highscore")
    if storedHighScore == nil {
        highScore = 0
        highscoreLabel.text = "HighScore: \(highScore)"
        
    }
    
    if let newScore = storedHighScore as? Int {
        highScore = newScore
        highscoreLabel.text = "HighScore: \(highScore)"
        
        
    }
    
    //Images
    pikachu1.isUserInteractionEnabled = true
    pikachu2.isUserInteractionEnabled = true
    pikachu3.isUserInteractionEnabled = true
    pikachu4.isUserInteractionEnabled = true
    pikachu5.isUserInteractionEnabled = true
    pikachu6.isUserInteractionEnabled = true
    pikachu7.isUserInteractionEnabled = true
    pikachu8.isUserInteractionEnabled = true
    pikachu9.isUserInteractionEnabled = true
    
    let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
    let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
    let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
    let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
    let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
    let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
    let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
    let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
    let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
    
    pikachu1.addGestureRecognizer(recognizer1)
    pikachu2.addGestureRecognizer(recognizer2)
    pikachu3.addGestureRecognizer(recognizer3)
    pikachu4.addGestureRecognizer(recognizer4)
    pikachu5.addGestureRecognizer(recognizer5)
    pikachu6.addGestureRecognizer(recognizer6)
    pikachu7.addGestureRecognizer(recognizer7)
    pikachu8.addGestureRecognizer(recognizer8)
    pikachu9.addGestureRecognizer(recognizer9)
    
    pikachuArray = [pikachu1, pikachu2, pikachu3, pikachu4, pikachu5, pikachu6, pikachu7, pikachu8, pikachu9]
    
   counter = 15
    timeLabel.text = String(counter)
    timer = Timer.scheduledTimer(timeInterval: 1,
                                 target: self,
                                 selector: #selector(countDown),
                                 userInfo: nil,
                                 repeats: true)
    hideTimer = Timer.scheduledTimer(timeInterval: 0.5,
                                     target: self,
                                     selector: #selector(hidePikachu),
                                     userInfo: nil,
                                     repeats: true)
    
    hidePikachu()
}

    @objc func hidePikachu() {
        for pikachu in pikachuArray {
            pikachu.isHidden = true
        }
        let random = Int(arc4random_uniform(UInt32(pikachuArray.count - 1)))
        pikachuArray[random].isHidden = false
    }
    
    
    
    @objc func increaseScore(){
        score += 1
        scoreLabel.text = "Score: \(score)"
    }
    @objc func countDown() {
        counter -= 1
        timeLabel.text = String(counter)
        if counter == 0 {
            timer.invalidate()
            hideTimer.invalidate()
            for pikachu in pikachuArray {
                pikachu.isHidden = true
            }
            
        //HighScore
            if self.score > self.highScore {
                self.highScore = self.score
                highscoreLabel.text = "HighScore: \(self.highScore)"
                UserDefaults.standard.set(self.highScore, forKey: "highscore")
            }
            
        
        //Alert
        let alert = UIAlertController(title: "Time's Up",
                                      message: "Do you want to play again?",
                                      preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK",
                                     style: UIAlertAction.Style.cancel,
                                     handler: nil)
        let replayButton = UIAlertAction(title: "Replay",
                                         style: UIAlertAction.Style.default) { UIAlertAction in
            self.score = 0
            self.scoreLabel.text = "Score : \(self.score)"
            self.counter = 15
            self.timeLabel.text = String(self.counter)
            self.timer = Timer.scheduledTimer(timeInterval: 1,
                                         target: self,
                                         selector: #selector(self.countDown),
                                         userInfo: nil,
                                         repeats: true)
            self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5,
                                             target: self,
                                             selector: #selector(self.hidePikachu),
                                             userInfo: nil,
                                             repeats: true)
            
            
            
        }
            alert.addAction(okButton)
            alert.addAction(replayButton)
            self.present(alert, animated: true, completion: nil)
        }
    }
}

