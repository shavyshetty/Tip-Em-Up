//
//  ViewController.swift
//  TipEmUp
//
//  Created by Shavy on 1/4/17.
//  Copyright © 2017 Shavy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //declaring variables
    @IBOutlet weak var textBillAmount: UITextField!
    @IBOutlet weak var textTipAmount: UITextField!
    @IBOutlet weak var textSelector: UISegmentedControl!
    @IBOutlet weak var textTotalAmount: UITextField!
    @IBOutlet weak var Total2ppl: UITextField!
    @IBOutlet weak var Total3ppl: UITextField!
    @IBOutlet weak var Total4ppl: UITextField!
    let defaults = UserDefaults.standard

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        defaults.synchronize()
        print (defaults.integer(forKey: "tipindex"))
        textSelector.selectedSegmentIndex = defaults.integer(forKey: "tipindex")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Event called when tapping anywhere on the screen
    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
        defaults.synchronize()
        textSelector.selectedSegmentIndex = defaults.integer(forKey: "tipindex")
    }
    
    // Event called whenever the bill amount changes
    @IBAction func onBillAmountChange(_ sender: Any) {
     
     let TipPercentages = [0.10, 0.15, 0.20]
        
     let BillAmount = Double(textBillAmount.text!) ?? 0
     let FinalTip =    BillAmount * TipPercentages[textSelector.selectedSegmentIndex]
     let FinalAmount = BillAmount + FinalTip
     textTipAmount.text = String(format: "$%.2f", FinalTip)
     textTotalAmount.text = String(format: "$%.2f",FinalAmount)
     Total2ppl.text = String(format: "$%.2f",FinalAmount/2)
     Total3ppl.text = String(format: "$%.2f",FinalAmount/3)
     Total2ppl.text = String(format: "$%.2f",FinalAmount/4)
    }

    // On change of the selector field for tip %
    @IBAction func onSelectorValueChange() {
        onBillAmountChange(self)
    }
}


