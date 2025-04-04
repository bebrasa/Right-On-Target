//
//  ViewController.swift
//  Right on Target
//
//  Created by Никита Кочанов on 04.04.2025.
//

import UIKit

class ViewController: UIViewController {
    
    var game: Game!
    
    @IBOutlet var slider: UISlider!
    @IBOutlet var label: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        game = Game(generator: Generator(), rounds: 5)
        updateLabelWithSecretNumber(newText: String(game.currentRound.currentSecretValue))
    }
    
    @IBAction func checkNumber() {
        game.playerGuessed(value: Int(slider.value))
        if game.isGameEnden {
            showAlertWith(score: game.score)
            game.restartGame()
        } else {
            game.startNewRound()
        }
        updateLabelWithSecretNumber(newText: String(game.currentRound.currentSecretValue))
    }
    
    private func updateLabelWithSecretNumber(newText: String ) {
            label.text = newText
    }
    
    private func showAlertWith(score: Int) {
        let alert = UIAlertController(title: "Game Over", message: "Your score is \(score)/250", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Restart", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func showPreviousScreen() {
        self.dismiss(animated: true, completion: nil)
    }
}

