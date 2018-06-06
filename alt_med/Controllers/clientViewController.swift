//
//  clientViewController.swift
//  alt_med
//
//  Created by Oksana Gorbachenko on 3/2/18.
//  Copyright © 2018 Oksana Gorbachenko. All rights reserved.
//

import UIKit
import RealmSwift

class clientViewController: UIViewController {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var genderTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func goToClient(_ sender: UIButton) {
//        self.performSegue(withIdentifier: "goToAllClients", sender: self)
    }
    @IBAction func clickAddClientButton(_ sender: UIButton) {
        
        let newClient = Clients()
        newClient.name = nameTextField.text!
        newClient.age = Int(ageTextField.text!)!
        newClient.genger = genderTextField.text!
        newClient.phone = phoneTextField.text!
        
        let realm = try! Realm()
        
        try! realm.write {
            realm.add(newClient)
            print("Added \(newClient.name) to Realm")
        }
       
    }


}
