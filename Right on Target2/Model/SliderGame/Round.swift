//
//  Round.swift
//  Right on Target2
//
//  Created by Никита Кочанов on 04.04.2025.
//

import Foundation

protocol GameRoundProtocol {
    var score: Int { get }
    var currentSecretValue: Int { get }
    
    func calculateScore(with: Int)
}

class Round: GameRoundProtocol {
    var score: Int = 0
    var currentSecretValue: Int = 0
    
    func calculateScore(with value: Int) {
        if value > currentSecretValue {
            score += 50 - value + currentSecretValue
        } else if value < currentSecretValue {
            score += 50 - currentSecretValue + value
        } else {
        score += 50
        }
    }
}
