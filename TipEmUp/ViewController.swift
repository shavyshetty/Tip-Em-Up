//
//  ViewController.swift
//  TipEmUp
//
//  Created by Shavy on 1/4/17.
//  Copyright © 2017 Shavy. All rights reserved.
//

import UIKit

class ViewController: UIViewController{
    
    //declaring variables
    @IBOutlet weak var textBillAmount: UITextField!
    @IBOutlet weak var textTipAmount: UITextField!
    @IBOutlet weak var textSelector: UISegmentedControl!
    @IBOutlet weak var textTotalAmount: UITextField!
    @IBOutlet weak var Total2ppl: UITextField!
    @IBOutlet weak var Total3ppl: UITextField!
    @IBOutlet weak var Total4ppl: UITextField!
    let defaults = UserDefaults.standard
    var currtype = "$"
    let TipPercentages = [0.10, 0.15, 0.20]
    let Currencies = ["$","£","₹","€"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        defaults.synchronize()
        
        textSelector.selectedSegmentIndex = defaults.integer(forKey: "tipindex")
        //currtype = defaults.string(forKey: "currency type")!
        
        //Persists the data across restarts
        if(defaults.object(forKey: "lastlogin") == nil)
        {
            defaults.set(Date(), forKey: "lastlogin")
        }
        let start = defaults.object(forKey: "lastlogin")
        let end = Date();
        
        var timeInterval: Double = (start! as AnyObject).timeIntervalSince(end);
        timeInterval = timeInterval * -1.0;
        
        if(timeInterval > 600.0)
        {
            defaults.set(0, forKey: "billAmount")
            defaults.set(0, forKey: "tipIndex")
        }
        
        textBillAmount.text = String(format: "%.2f",defaults.double(forKey: "billAmount"))
        defaults.set(Date(), forKey: "lastlogin")
        
        //Make Text field first responder
        self.textBillAmount.becomeFirstResponder()
        
        onBillAmountChange(self)
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
        onBillAmountChange(self)
    }
    
    // Event called whenever the bill amount changes
    @IBAction func onBillAmountChange(_ sender: Any) {
        

        currtype = Currencies[defaults.integer(forKey: "currency type")]
        let BillAmount = Double(textBillAmount.text!) ?? 0
        let FinalTip =    BillAmount * TipPercentages[textSelector.selectedSegmentIndex]
        let FinalAmount = BillAmount + FinalTip
        textTipAmount.text = String(format: "\(currtype)%.2f", FinalTip)
        textTotalAmount.text = String(format: "\(currtype)%.2f",FinalAmount)
        Total2ppl.text = String(format: "\(currtype)%.2f",FinalAmount/2)
        Total3ppl.text = String(format: "\(currtype)%.2f",FinalAmount/3)
        Total4ppl.text = String(format: "\(currtype)%.2f",FinalAmount/4)
        defaults.set(BillAmount, forKey: "billAmount")
    }
    
    // On change of the selector field for tip %
    @IBAction func onSelectorValueChange() {
        onBillAmountChange(self)
    }
}


