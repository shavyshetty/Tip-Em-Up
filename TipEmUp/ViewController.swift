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
    @IBOutlet weak var NeedHelpButton: UIButton!
    
    //suggestor view elements
    @IBOutlet weak var SuggestorView: UIView!
    @IBOutlet weak var ServiceSuggestorControl: UISegmentedControl!
    @IBOutlet weak var TimelinessSuggestorControl: UISegmentedControl!
    @IBOutlet weak var HelpfullnessSuggestorControl: UISegmentedControl!
    @IBOutlet weak var ClosePopupButton: UIButton!
    var dirty = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Synchronise defaults
        defaults.synchronize()
        
        //Hide suggestions box
        SuggestorView.isHidden = true
        
        
        textSelector.selectedSegmentIndex = defaults.integer(forKey: "tipindex")
        
        //Persists the data across restarts
        if(defaults.object(forKey: "lastlogin") == nil)
        {
            defaults.set(Date(), forKey: "lastlogin")
        }
        let start = defaults.object(forKey: "lastlogin")
        let end = Date();
        
        var timeInterval: Double = (start! as AnyObject).timeIntervalSince(end);
        timeInterval = timeInterval * -1.0;
        
        //Greater than 10 mins elapsed?
        if(timeInterval > 600.0)
        {
            defaults.set(0, forKey: "billAmount")
            defaults.set(0, forKey: "tipIndex")
        }
        
        textBillAmount.text = String(format: "%.2f",defaults.double(forKey: "billAmount"))
        defaults.set(Date(), forKey: "lastlogin")
        
        //Make Text field first responder
        self.textBillAmount.becomeFirstResponder()
        
        //Calulate initial results
        onBillAmountChange(self)
    }
    
    //Each time the view comes to foreground
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        if dirty != 1
        {
            defaults.synchronize()
            textSelector.selectedSegmentIndex = defaults.integer(forKey: "tipindex")
        }
        onBillAmountChange(self)

        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Event called when tapping anywhere on the screen
    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
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
    
    //SuggestionsView Open
    @IBAction func SuggestorPopUpOpen(_ sender: Any) {
        //Assigning default values to control
        view.endEditing(true)
        
        //only initilaise if using of the first time this session
        if (dirty == 0)
        {
            ServiceSuggestorControl.selectedSegmentIndex = 2
            TimelinessSuggestorControl.selectedSegmentIndex = 1
            HelpfullnessSuggestorControl.selectedSegmentIndex = 1
            dirty = 1
        }
        SuggestorView.isHidden = false
    }
    
    //SuggestionsView Closed
    
    @IBAction func SuggestionsPopUpClose(_ sender: Any) {
        GenerateSuggestion()
        onBillAmountChange(self)
        SuggestorView.isHidden = true
    }
    
    func GenerateSuggestion()
    {
        let rating = ServiceSuggestorControl.selectedSegmentIndex + TimelinessSuggestorControl.selectedSegmentIndex + HelpfullnessSuggestorControl.selectedSegmentIndex
        switch rating {
        case 0,1:
            textSelector.selectedSegmentIndex = 0
        case 2,3:
            textSelector.selectedSegmentIndex = 1
        case 4,5,6:
            textSelector.selectedSegmentIndex = 2
        default:
            textSelector.selectedSegmentIndex = 1
        }
    }
    
    
    
}


