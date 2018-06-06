//
//  RegisterViewController.swift
//  alt_med
//
//  Created by Oksana Gorbachenko on 2/25/18.
//  Copyright © 2018 Oksana Gorbachenko. All rights reserved.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var outputLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func actionInput(_ sender: UITextField) {
        //view.endEditing(true)
    }
    @IBAction func registerPressed(_ sender: UIButton) {
                //TODO: Set up a new user on our Firbase database
                view.endEditing(true)
                Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) {
                    (user, error) in
        
                    if error != nil {
                        self.outputLabel.text = String(describing: error!.localizedDescription)
                        print(error!)
                    }
                    else {
                        //succsess
                        self.outputLabel.text = "Registration is succsessful"
               
                     //  self.performSegue(withIdentifier: "registerToMain", sender: self)
                    }
                }
        
    }
    

        

      
    



}
