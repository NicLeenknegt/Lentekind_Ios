//
//  ProfileController.swift
//  Lentekind_app
//
//  Created by Nic Leenknegt on 20/01/2019.
//  Copyright © 2019 Nicolaas Leenknegt. All rights reserved.
//

import UIKit

class ProfileController:UIViewController {
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var telNrLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var errorLbl: UILabel!
    let userService:AfUserService = AfUserService()
    override func viewDidLoad() {
        super.viewDidLoad()
        let user = userService.getUser()
        nameLbl.text = user.firstname + " " + user.lastname
        telNrLbl.text = user.telNr
        emailLbl.text = user.email
        errorLbl.text = ""
    }
    
    @IBAction func onLogOutClick(_ sender: Any) {
        errorLbl.text = ""
        if userService.nukeUser() {
            performSegue(withIdentifier: "LoginSegue", sender: nil)
        } else {
            errorLbl.text = "Er is iets mis gegaan, probeer later opnieuw."
        }
    }
}
