//
//  ThirdViewController.swift
//  Right on Target2
//
//  Created by Никита Кочанов on 05.04.2025.
//

import UIKit

class ThirdViewController: UIViewController {
    
    var game: ColorGame!
    
    @IBOutlet var label1: UILabel!
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    @IBOutlet var button4: UIButton!
    
    override func loadView() {
        super.loadView()
        game = ColorGame(generator: GeneratorColor(), rounds: 5)
        
        // Обновляем лейбл с цветом
        let secretColor = game.currentRound.currentSecretColor
        updateLabelWithSecretColor(newText: secretColor.toHex() ?? "")
        
        button1.layer.cornerRadius = 10  // Скругление углов для button1
        button1.layer.masksToBounds = true  // Обеспечивает правильное обрезание содержимого

        button2.layer.cornerRadius = 10
        button2.layer.masksToBounds = true

        button3.layer.cornerRadius = 10
        button3.layer.masksToBounds = true

        button4.layer.cornerRadius = 10
        button4.layer.masksToBounds = true
        
        // Генерируем цвета для кнопок
        assignColorsToButtons(secretColor: secretColor)
    }
    
    @IBAction func showPreviousScreen() {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func updateLabelWithSecretColor(newText: String ) {
        label1.text = newText
    }
    
    private func showAlertWith(score: Int) {
        let alert = UIAlertController(title: "Game Over", message: "Your score is \(score)/5", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Restart", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    // Функция для назначения случайных цветов кнопкам
    private func assignColorsToButtons(secretColor: UIColor) {
        // Генерируем массив цветов для кнопок
        let colors = game.currentRound.generateColorsForButtons()
        
        // Назначаем цвета кнопкам
        button1.backgroundColor = colors[0]
        button2.backgroundColor = colors[1]
        button3.backgroundColor = colors[2]
        button4.backgroundColor = colors[3]
    }
    
    // Функция для проверки ответа
    @IBAction func checkAnswer(_ sender: UIButton) {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.prepare()
        generator.impactOccurred()
        // Добавим анимацию нажатия
        UIView.animate(withDuration: 0.1,
                       animations: {
                           sender.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)  // Уменьшаем кнопку
                       },
                       completion: { _ in
                           UIView.animate(withDuration: 0.1) {
                               sender.transform = CGAffineTransform.identity  // Возвращаем к исходному размеру
                           }
                       })
        
        // Получаем цвет кнопки
        guard let selectedColor = sender.backgroundColor else {
            print("No background color set for the button")
            return
        }
        
        // Получаем HEX строку из лейбла
        let secretColorHex = label1.text ?? ""
        
        // Преобразуем цвет кнопки в HEX строку
        guard let selectedColorHex = selectedColor.toHex() else {
            print("Failed to convert selected color to hex")
            return
        }
        
        // Сравниваем HEX строки кнопки и лейбла
        if selectedColorHex.lowercased() == secretColorHex.lowercased() {
            game.playerGuess(color: selectedColor, text: secretColorHex)
        }
        
        if game.isGameEnden {
            // Показываем алерт, когда игра завершена
            showAlertWith(score: game.score)
            game.restartGame()
        } else {
            // Начинаем новый раунд
            game.startNewRound()
            
            // Обновляем лейбл с новым секретным цветом
            updateLabelWithSecretColor(newText: game.currentRound.currentSecretColor.toHex() ?? "")
            
            // Генерируем новые цвета для кнопок
            assignColorsToButtons(secretColor: game.currentRound.currentSecretColor)
        }
    }
}

