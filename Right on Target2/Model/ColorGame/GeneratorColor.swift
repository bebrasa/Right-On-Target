//
//  Generator.swift
//  Right on Target2
//
//  Created by Никита Кочанов on 05.04.2025.
//

import Foundation
import UIKit

protocol ColorGeneratorProtocol {
    func getColor() -> UIColor
}

class GeneratorColor: ColorGeneratorProtocol {
    func getColor() -> UIColor {
        let randomColor = UIColor(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1), alpha: 1)
        return randomColor
    }
}
