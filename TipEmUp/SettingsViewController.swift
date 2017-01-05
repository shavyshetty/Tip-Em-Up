//
//  SettingsViewController.swift
//  TipEmUp
//
//  Created by Shavy on 1/4/17.
//  Copyright © 2017 Shavy. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var DefaultSelector: UISegmentedControl!
    let defaults = UserDefaults.standard
    
    
    override func viewDidLoad() {
        super.viewDidLoad()


        // Do any additional setup after loading the view.
        DefaultSelector.selectedSegmentIndex = defaults.integer(forKey: "tipindex")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func DefaultChanged(_ sender: Any) {
        var tipIndex = 0
        tipIndex = DefaultSelector.selectedSegmentIndex
        defaults.set(tipIndex, forKey: "tipindex")
        print(defaults.integer(forKey: "tipindex"))
        defaults.synchronize()
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}