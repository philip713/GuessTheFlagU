//
//  ViewController.swift
//  GuessTheFlag
//
//  Created by Philip Janzel Paradeza on 2022-10-26.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var scoreLabel: UILabel!
    var countries = [String]()
    var correctAnswer = 0
    var score = 0
    var quesNum = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        button1.layer.borderWidth = 1
//        button2.layer.borderWidth = 1
//        button3.layer.borderWidth = 1
//
//        button1.layer.borderColor = UIColor.lightGray.cgColor
//        button2.layer.borderColor = UIColor.lightGray.cgColor
//        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        scoreLabel.text = "Score: \(score)"
        
        countries += ["Estonia", "France", "Germany", "Ireland", "Italy", "Monaco", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"]
        
        askQuestion(action: nil)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(scoreTapped))
    }
    
    func askQuestion(action: UIAlertAction!){
        quesNum += 1
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        title = countries[correctAnswer].uppercased()
        
    }

    @IBAction func buttonTapped(_ sender: Any) {
        print(quesNum)
        var title : String
        if (sender as AnyObject).tag == correctAnswer {
            title = "Correct"
            score += 1
        }
        else {
            title = "Wrong! Thats the flag of \(countries[(sender as AnyObject).tag])"
            score -= 1
        }
        
        scoreLabel.text = "Score: \(score)"
        
        if(quesNum < 10){
            let ac = UIAlertController(title: title, message: "Your score is \(score).", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
            present(ac, animated: true)
        }
        else{
            
            let ac = UIAlertController(title: title, message: "Your final score is \(score).", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Restart Game", style: .default, handler: askQuestion))
            present(ac, animated: true)
            
            quesNum = 0
            score = 0
            scoreLabel.text = "Score: \(score)"
        }
        
        
    }
    
    @objc func scoreTapped(){
        let str = "Score: \(score)"
        let vc = UIActivityViewController(activityItems: [str], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
    
}

