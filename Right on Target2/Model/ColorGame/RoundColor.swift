import Foundation
import UIKit

protocol ColorForRoundProtocol {
    var score: Int { get }
    var currentSecretColor: UIColor { get set }
    
    func calculateScore(with color: UIColor, hexCode: String)
    func generateRandomColor() -> UIColor
    func generateColorsForButtons() -> [UIColor]
}

extension UIColor {
    func toHex() -> String? {
        
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        // Получаем компоненты цвета
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        // Преобразуем в HEX строку
        let rgb = (Int(red * 255) << 16) | (Int(green * 255) << 8) | Int(blue * 255)
        return String(format: "#%06x", rgb)
    }
}

class RoundColor: ColorForRoundProtocol {
    var score: Int = 0
    var currentSecretColor: UIColor = .systemBlue
    
    // Генерация случайного цвета
    func generateRandomColor() -> UIColor {
        return UIColor(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1), alpha: 1)
    }
    
    // Генерация массива из 4 случайных цветов, один из которых совпадает с секретным цветом
    func generateColorsForButtons() -> [UIColor] {
        var colors: [UIColor] = []
        
        // Добавляем секретный цвет
        colors.append(currentSecretColor)
        
        // Генерируем 3 случайных цвета
        for _ in 0..<3 {
            colors.append(generateRandomColor())
        }
        
        // Перемешиваем цвета
        colors.shuffle()
        return colors
    }
    
    func calculateScore(with color: UIColor, hexCode: String) {
        if let hexColor = color.toHex(), hexColor.lowercased() == hexCode.lowercased() {
            score += 1
        }
    }
}
