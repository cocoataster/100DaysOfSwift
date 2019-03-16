//
//  ViewController.swift
//  Project2
//
//  Created by Eric Sans Alvarez on 20/02/2019.
//  Copyright © 2019 Eric Sans Alvarez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var count = 0
    
    override func viewDidLayoutSubviews() {
        setUpBtnLayer()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        askQuestion()
    }
    
    func askQuestion(action: UIAlertAction! = nil) {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button1.tag = 0
        
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button2.tag = 1
        
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        button3.tag = 2
        
        title = countries[correctAnswer].uppercased() + " - Score: \(score)"
        
        count += 1
        if count > 10 {
            let ac = UIAlertController(title: "10 Questions Answered", message: "Your final score is \(score)", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Restart game", style: .default, handler: askQuestion))
            present(ac, animated: true)
            restartGame()
        }
    }
    
    func restartGame() {
        count = 0
        score = 0
    }
    
    func setUpBtnLayer() {
        for case let btn as UIButton in view.subviews {
            btn.layer.borderWidth = 1
            btn.layer.borderColor = UIColor.lightGray.cgColor
            btn.layer.cornerRadius = 5
            btn.clipsToBounds = true
        }
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        
        if sender.tag == correctAnswer {
            title = "Correct"
            score += 1
        } else {
            title = "Wrong! That's the flag of \(countries[sender.tag].uppercased())"
            score -= 1
        }
        
        let ac = UIAlertController(title: title, message: "Your score is \(score)", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
        
        present(ac, animated: true)
    }
    
}

