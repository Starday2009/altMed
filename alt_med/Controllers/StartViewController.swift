//
//  ViewController.swift
//  alt_med
//
//  Created by Oksana Gorbachenko on 1/21/18.
//  Copyright © 2018 Oksana Gorbachenko. All rights reserved.
//

import UIKit
import Firebase

class StartViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if Auth.auth().currentUser != nil {
            self.performSegue(withIdentifier: "logged", sender: self)
            print("logged")
        } else {
            print("not logged")
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
//    @IBAction func doItButton(_ sender: UIButton) {
//    }
    //    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {}
  

}

