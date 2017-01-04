//
//  ViewController.swift
//  TipEmUp
//
//  Created by Shavy on 1/4/17.
//  Copyright © 2017 Shavy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textBillAmount: UITextField!
    @IBOutlet weak var textTipAmount: UITextField!
    @IBOutlet weak var textSelector: UISegmentedControl!
    
    @IBOutlet weak var textTotalAmount: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }
    @IBAction func onBillAmountChange(_ sender: Any) {
     
     let TipPercentages = [0.10, 0.15, 0.20]
        
     let TotalAmount = Double(textBillAmount.text!) ?? 0
     let FinalTip =    TotalAmount * TipPercentages[textSelector.selectedSegmentIndex]
     textTipAmount.text = String(format: "$%.2f", FinalTip)
     textTotalAmount.text = String(format: "$%.2f",TotalAmount + FinalTip)
    }

    @IBAction func onSelectorValueChange() {
        onBillAmountChange(self)
    }
}


