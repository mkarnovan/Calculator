//
//  ViewController.swift
//  Calculator
//
//  Created by maxik on 12.03.17.
//  Copyright © 2017 Maxim Karnovan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var displayResultLabel: UILabel!
    
    var stillTyping = false
    var firstOperand: Double = 0
    var secondOperand: Double = 0
    var operationSign: String = ""
    var dotIsPlaced = false
    
    
    var inputValue: Double {
        get {
            return Double(displayResultLabel.text!)!
        }
        set{
            let value = "\(newValue)"
            let valueArray = value.components(separatedBy: ".")
            if valueArray[1] == "0" {
                displayResultLabel.text = "\(valueArray[0])"
            } else {
                displayResultLabel.text = "\(newValue)"
            }
            stillTyping = false
        }
    }
        
    
    @IBAction func numberPressed(_ sender: UIButton) {
        let number = sender.currentTitle!
        
        if stillTyping {
            if (displayResultLabel.text?.characters.count)! < 20 {
                displayResultLabel.text = displayResultLabel.text! + number
            }
        } else {
            displayResultLabel.text = number
            stillTyping = true
        }
    }
    
    private func operateWithTwoOperands(operation: (Double, Double) -> Double ){
        inputValue = operation(firstOperand,secondOperand)
        stillTyping = false
    }
    
    @IBAction func twoOperandsSignPress(_ sender: UIButton) {
        operationSign = sender.currentTitle!
        firstOperand = inputValue
        stillTyping = false
        displayResultLabel.text = " "
        dotIsPlaced = false
    }

    @IBAction func eualitySignPress(_ sender: UIButton) {
        if stillTyping {
            secondOperand = inputValue
        }
        dotIsPlaced = false
        switch operationSign {
        case "+":
            operateWithTwoOperands{$0 + $1}
        case "-":
            operateWithTwoOperands{$0 - $1}
        case "×":
            operateWithTwoOperands{$0 * $1}
        case "÷":
            if secondOperand == 0 {
                
            }
            operateWithTwoOperands{$0 / $1}
        default:
            break
        }
    }
    
    
    
    @IBAction func clearButton(_ sender: UIButton) {
        firstOperand = 0
        secondOperand = 0
        inputValue = 0
        displayResultLabel.text = "0"
        stillTyping = false
        dotIsPlaced = false
        operationSign = ""
        
    }
    
    @IBAction func plusMinus(_ sender: UIButton) {
        inputValue = -inputValue
    }
    
    @IBAction func procentButtonPress(_ sender: UIButton) {
        if firstOperand == 0 {
            inputValue = inputValue / 100
        } else {
            secondOperand = firstOperand * inputValue / 100
        }
    }
    
    @IBAction func sqrtButtonPress(_ sender: UIButton) {
        inputValue = sqrt(inputValue)
    }
    
    @IBAction func decimalButton(_ sender: UIButton) {
        if stillTyping && !dotIsPlaced {
            displayResultLabel.text = displayResultLabel.text! + "."
            dotIsPlaced = true
        }else if !stillTyping && !dotIsPlaced {
            displayResultLabel.text = "0."
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print(segue.identifier)
        (segue.destination as! TableViewController).viewDidLoad()
    }
}

