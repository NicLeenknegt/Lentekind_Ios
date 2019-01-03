//
//  ViewController.swift
//  Lentekind_app
//
//  Created by Nicolaas Leenknegt on 27/12/2018.
//  Copyright © 2018 Nicolaas Leenknegt. All rights reserved.
//

import UIKit

class LoginController: UIViewController {

    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    
    let emailRegex = NSPredicate(format:"SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
    var userService:AfUserService = AfUserService()
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onLoginClick(_ sender: Any) {
        guard let email = emailTxt.text, let password = passwordTxt.text else { return }
        guard !email.isEmpty, !password.isEmpty, emailRegex.evaluate(with: email) else { return }
        userService.login(email: email, password: password) { (user, error) in
            if let error = error {
                return print(error.localizedDescription)
            } else {
                if let user = user {
                    switch user.rights {
                    case 1:self.performSegue(withIdentifier: "ParentSegue", sender: nil)
                    default: self.performSegue(withIdentifier: "AdminSegue", sender: nil)
                    }
                }
            }
        }
        
    }
    
}

