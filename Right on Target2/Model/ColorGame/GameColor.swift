//
//  Game.swift
//  Right on Target2
//
//  Created by Никита Кочанов on 05.04.2025.
//

import Foundation
import UIKit

protocol ColorGameProtocol {
    var score: Int { get }
    var isGameEnden: Bool { get }
    var secretColorGenerator: ColorGeneratorProtocol { get }
    var currentRound: ColorForRoundProtocol { get }
    
    func restartGame()
    func startNewRound()
}

class ColorGame: ColorGameProtocol {
    var score: Int = 0
    private var lastRound: Int
    var currentRoundNumber: Int = 0
    var currentRound: ColorForRoundProtocol
    var secretColorGenerator: ColorGeneratorProtocol
    var isGameEnden: Bool {
        if currentRoundNumber >= lastRound {
            return true
        } else {
            return false
        }
    }
        init?(generator: ColorGeneratorProtocol, rounds: Int){
            guard rounds > 0 else {
                return nil
            }
            self.secretColorGenerator = generator
            self.lastRound = rounds
            self.currentRound = RoundColor()
            startNewRound()
        }
    
    func restartGame() {
        score = 0
        currentRoundNumber = 0
        startNewRound()
    }
    
    func startNewRound() {
        guard !isGameEnden else {
            return
        }
        currentRoundNumber += 1
        let secretColor = secretColorGenerator.getColor()
        let round = RoundColor()
        round.currentSecretColor = secretColor
        currentRound = round
    }
    
    func playerGuess(color: UIColor, text: String) {
        currentRound.calculateScore(with: color, hexCode: text)
        score += currentRound.score
    }
}
