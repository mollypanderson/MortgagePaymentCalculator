//
//  ViewController.swift
//  MortgagePaymentCalculator
//
//  Created by Molly Anderson on 6/7/20.
//  Copyright © 2020 Molly Anderson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var leftView: UIView!
    @IBOutlet weak var rightView: UIView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var paymentsField: UITextField!
    
    @IBOutlet weak var interestRateField: UITextField!
    
    @IBOutlet weak var loanAmountField: UITextField!
    
    @IBOutlet weak var paymentResultField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissMyKeyboard))
            
            view.addGestureRecognizer(tap)
        
        loanAmountField.delegate = self
        paymentsField.delegate = self
        interestRateField.delegate = self
        
    }
    
    @objc func dismissMyKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func calculateIsPressed(_ sender: UIButton) {
        
        let principal = Double(loanAmountField.text!)
        let payments = Double(paymentsField.text!)
        let interestRate = Double(interestRateField.text!)

        if principal != nil && payments != nil && interestRate != nil {
            let result = calculatePayment(principalIn: principal ?? 0, paymentsIn: payments ?? 0, interestRateIn: interestRate ?? 0)
            paymentResultField.text = String(format: "$%.2f", result)
            
        } else {
        
        paymentResultField.text = "Error"
            
        }
    }
    
//    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
//        return UIOrientationMask(rawValue: (UIInterfaceOrientationMask.portrait.rawValue |
//            UIInterfaceOrientationMask.landscapeLeft.rawValue))
//    }

}

func calculatePayment(principalIn: Double, paymentsIn: Double, interestRateIn: Double) -> Double {
    let interestConverted = Double(interestRateIn / 100)
    
    let result = principalIn * (interestConverted * pow((1 + interestConverted), paymentsIn)) / (pow((1 + interestConverted), paymentsIn) - 1)
    
    return result
    
}


extension ViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}

