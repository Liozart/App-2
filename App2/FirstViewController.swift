//
//  FirstViewController.swift
//  App2

import UIKit

class FirstViewController: UIViewController {
    
    @IBOutlet var pseudoT : UITextField!
    let friendListController : UIViewController = SecondViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onClickValidate(sender: UIButton) {
        let pseudo = pseudoT.text!
        if pseudo != "" {
            // set up the session
            let config = URLSessionConfiguration.default
            let session = URLSession(configuration: config)
            
            // Set up the URL request
            guard let url = URL(string: "https://steamid.io/lookup/" + pseudo) else {
                print("Error: cannot create URL")
                return
            }
            let urlRequest = URLRequest(url: url)
            
            // make the request
            let task = session.dataTask(with: urlRequest) {
                (data, response, error) in
                // check for any errors
                guard error == nil else {
                    print("error calling GET")
                    print(error!)
                    return
                }
                // make sure we got data
                guard let responseData = data else {
                    print("Error: did not receive data")
                    return
                }
                let html = String(data: responseData, encoding: String.Encoding.utf8)!
                // Search in the HTML content " "keywords": "steamid, STEAM_0:1:xxxxxx, [U:1:xxxxxxxx], the number we need, pseudo", [...] "
                // So we search in for "keywords", then iterate to the third "," then cut whats after
                let indexStart = html.range(of: "keywords")!
                var content = String(html[indexStart.lowerBound..<html.endIndex])
                for _ in 0...2 {
                    content = String(content[content.range(of: ", ")!.upperBound..<content.endIndex])
                }
                SecondViewController.accounts += [String(content[content.startIndex..<content.index(of: ",")!])]
            }
            task.resume()
        }
    }
}

