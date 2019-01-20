//
//  ChildDetailController.swift
//  Lentekind_app
//
//  Created by Nicolaas Leenknegt on 29/12/2018.
//  Copyright © 2018 Nicolaas Leenknegt. All rights reserved.
//

import UIKit

class ChildDetailViewController:UITableViewController,MedicationDelegate {
    
    
    @IBOutlet weak var addDatesBtn: UIButton!
    @IBOutlet weak var firstnameTxt: UITextField!
    @IBOutlet weak var birthDatePicker: UIDatePicker!
    @IBOutlet weak var allergiesTxt: UITextField!
    @IBOutlet weak var saveBtn: UIBarButtonItem!
    @IBOutlet weak var lastnameTxt: UITextField!
    
    var child:Child = Child()
    let dateFormatter = DateFormatter()
    var firstname:String = ""
    var lastname:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        saveBtn.isEnabled = (!child.firstname.isEmpty || !child.lastname.isEmpty)
        if (!child.firstname.isEmpty) {
            firstnameTxt.text = child.firstname
            lastnameTxt.text = child.lastname
            dateFormatter.dateFormat = "MM-dd-yyyy"
            print("Dateobj: \(dateFormatter.string(from: child.birthDate))")
            print()
            birthDatePicker.date = child.birthDate
            allergiesTxt.text = child.allergies
        }
    }
    
    
    @IBAction func firstnameDidChange(_ sender: Any) {
        guard let fN:String = firstnameTxt.text else { return }
        saveBtn.isEnabled = !fN.isEmpty
    }
    
    @IBAction func lastnameDidChange(_ sender: Any) {
        guard let lN:String = lastnameTxt.text else { return }
        saveBtn.isEnabled = !lN.isEmpty
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "SaveUnwind":
            child.firstname = firstnameTxt.text ?? ""
            child.lastname = lastnameTxt.text ?? ""
            child.birthDate = birthDatePicker.date
            child.allergies = allergiesTxt.text ?? ""
            super.prepare(for: segue, sender: sender)
        case "MedicationSegue":
            (segue.destination as! MedicationListController)._medication = child.medication
            (segue.destination as! MedicationListController).delegate = self
        default:
            return
        }
    
        
    }
    
    func onMedicationChanged(type: [Medication]) {
        child._medication = type
    }
    
}
