//
//  Game.swift
//  Right on Target2
//
//  Created by Никита Кочанов on 04.04.2025.
//

import Foundation

protocol GameProtocol {
    var score: Int { get }
    var isGameEnden: Bool { get }
    var secretValueGenerator: GeneratorProtocol { get }
    var currentRound: GameRoundProtocol { get }
    
    func restartGame()
    func startNewRound()
}

class Game: GameProtocol {
    var score = 0
    var currentRound: GameRoundProtocol
    var secretValueGenerator: GeneratorProtocol
    private var lastRound: Int
    private var currentRoundNumber: Int = 1
    
    var isGameEnden: Bool {
        if currentRoundNumber >= lastRound {
            return true
        } else {
            return false
        }
    }
    
    init?(generator: GeneratorProtocol, rounds: Int){
        guard rounds > 0 else {
            return nil
        }
        self.secretValueGenerator = generator
        self.lastRound = rounds
        self.currentRound = Round()
        startNewRound()
    }
    
    func restartGame() {
        currentRoundNumber = 0
        score = 0
        startNewRound()
    }
    
    func startNewRound() {
        guard !isGameEnden else {
            return
        }
        currentRoundNumber += 1
        let secretValue = secretValueGenerator.getRandomValue()
        let round = Round()
        round.currentSecretValue = secretValue
        currentRound = round
    }
    
    func playerGuessed(value: Int) {
        currentRound.calculateScore(with: value)
        score += currentRound.score
    }
    
//    private func getNewSecretValue() -> Int {
//        (minSecretValue...maxSecretValue).randomElement()!
//    }
    
//    func calculateScore(with value: Int) {
//        if value > currentSecretValue {
//            score += 50 - value + currentSecretValue
//        } else if value < currentSecretValue {
//            score += 50 - currentSecretValue + value
//        } else {
//        score += 50
//        }
//    }
}
