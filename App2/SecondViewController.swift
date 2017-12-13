//
//  SecondViewController.swift
//  App2

import UIKit

class SecondViewController: UIViewController {
    
    static let APIKey : String = "604EF418E22EF6A1B62F41AB5332A606"
    static var accounts : [String] = []
    
    @IBOutlet var friendlist : UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if !SecondViewController.accounts.isEmpty {
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

