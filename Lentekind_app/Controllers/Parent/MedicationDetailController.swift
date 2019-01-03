//
//  MedicationDetailController.swift
//  Lentekind_app
//
//  Created by Nicolaas Leenknegt on 30/12/2018.
//  Copyright © 2018 Nicolaas Leenknegt. All rights reserved.
//

import UIKit

class MedicationDetailController: UITableViewController {
    
    @IBOutlet weak var nameTxt: UITextField!
    @IBOutlet weak var noteTxt: UITextField!
    @IBOutlet weak var saveBtn: UIBarButtonItem!
    var medicaton:Medication = Medication()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTxt.text = medicaton.name
        noteTxt.text = medicaton.note
        saveBtn.isEnabled = !medicaton.name.isEmpty
    }
    
    @IBAction func nameTxtDidChange(_ sender: Any) {
        medicaton.name = nameTxt.text ?? ""
        saveBtn.isEnabled = !medicaton.name.isEmpty
    }
    
    @IBAction func noteTxtDidChange(_ sender: Any) {
        medicaton.note = noteTxt.text ?? ""
    }
}
