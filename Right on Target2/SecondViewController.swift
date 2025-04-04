//
//  SecondViewController.swift
//  Right on Target
//
//  Created by Никита Кочанов on 04.04.2025.
//

import UIKit

class SecondViewController: UIViewController {
    
    override func loadView() {
        super.loadView()
    }
    
    @IBAction func showNextScreen(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if sender.tag == 2 {
            let viewController = storyboard.instantiateViewController(withIdentifier: "FirstViewController")
            self.present(viewController, animated: true, completion: nil)
        }
        else if sender.tag == 1 {
            let viewController = storyboard.instantiateViewController(withIdentifier: "ThirdViewController")
            self.present(viewController, animated: true, completion: nil)
        }
    }
}
