//
//  RegisterController.swift
//  Lentekind_app
//
//  Created by Nicolaas Leenknegt on 28/12/2018.
//  Copyright © 2018 Nicolaas Leenknegt. All rights reserved.
//

import UIKit

class RegisterController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var UserTypePicker: UIPickerView!
    @IBOutlet weak var firstnameTxt: UITextField!
    @IBOutlet weak var lastnameTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var telNrTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var passwordRepeatTxt: UITextField!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var passwordRepeatLbl: UILabel!
    @IBOutlet weak var errorLbl: UILabel!
    
    var selectedValue:Int = 1
    let pickerDataSource = ["Ouder", "Hoofdleiding"]
    let emailRegex = NSPredicate(format:"SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
    let userService:AfUserService = AfUserService()
    override func viewDidLoad() {
        super.viewDidLoad()
        print("check")
        UserTypePicker.dataSource = self
        UserTypePicker.delegate = self
    }
    
    @IBAction func onRegisterClick(_ sender: Any) {
        errorLbl.text = ""
        emailLbl.textColor = UIColor.darkText
        passwordRepeatLbl.textColor = UIColor.darkText
        guard let email = emailTxt.text, let firstname = firstnameTxt.text, let lastname = lastnameTxt.text, let telNr = telNrTxt.text, let password = passwordTxt.text, let passwordRepeat = passwordRepeatTxt.text else { return }
        
        guard !email.isEmpty && !firstname.isEmpty && !lastname.isEmpty && !telNr.isEmpty && !password.isEmpty && !passwordRepeat.isEmpty else {
            errorLbl.text = "Alle velden invullen"
            return
        }
        
        guard password == passwordRepeat else {
            errorLbl.text = "Wachtwoorden komen niet overeen"
            passwordRepeatLbl.textColor = UIColor.red
            return
        }
        
        guard emailRegex.evaluate(with: email) else {
            errorLbl.text = "Incorrecte mail"
            emailLbl.textColor = UIColor.red
            return
        }
        
        userService.register(req: RegisterReq(firstname:firstname, lastname:lastname, email:email, password:password, telNr: telNr, rights: selectedValue)) { (user, error) in
            if error != nil {
                self.errorLbl.text = "Er ging iets fout probeer later opnieux"
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
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerDataSource[row] {
        case "Ouder":
            selectedValue = 1
        default:
            selectedValue = 2
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerDataSource.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerDataSource[row]
    }
    
}
