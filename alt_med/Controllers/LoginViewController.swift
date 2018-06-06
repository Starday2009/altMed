//
//  LoginViewController.swift
//  alt_med
//
//  Created by Oksana Gorbachenko on 2/25/18.
//  Copyright © 2018 Oksana Gorbachenko. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var errorTextField: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var login_session:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func tapLoginButton(_ sender: UIButton) {
        
        view.endEditing(true)
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            
            if error != nil{
                print(error!)
                self.errorTextField.text = String(describing: error!.localizedDescription)
                
            } else{
                print("Log in successful!")
                
              self.errorTextField.text = "Log in successful!"
                
//                let storyboard = UIStoryboard(name: "procedures", bundle: nil)
//                storyboard.instantiateViewController(withIdentifier: "tabBarController")
                
                self.performSegue(withIdentifier: "login", sender: self)
            }
        }
        
        
    }
    

  
}
