//
//  Generator.swift
//  Right on Target2
//
//  Created by Никита Кочанов on 04.04.2025.
//

import Foundation

protocol GeneratorProtocol {
    func getRandomValue() -> Int
}

class Generator: GeneratorProtocol {
    func getRandomValue() -> Int {
        Int.random(in: 1...50)
    }
}
