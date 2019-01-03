//
//  MedicationListController.swift
//  Lentekind_app
//
//  Created by Nicolaas Leenknegt on 30/12/2018.
//  Copyright © 2018 Nicolaas Leenknegt. All rights reserved.
//

import UIKit

class MedicationListController:UITableViewController {

    @IBOutlet var medicationTable: UITableView!
    var _medication = [Medication]()
    var selectedMedication = Medication()
    var delegate:MedicationDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return _medication.count
        } else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = medicationTable.dequeueReusableCell(withIdentifier: "MedicationCell", for: indexPath)
        let medication = _medication[indexPath.row]
        cell.textLabel?.text = medication.name
        cell.detailTextLabel?.text = medication.note
        print(medication.note)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedMedication = _medication[indexPath.row]
        performSegue(withIdentifier: "MedicationDetailSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "MedicationDetailSegue" else { return }
        if medicationTable.indexPathForSelectedRow != nil {
            (segue.destination as! MedicationDetailController).medicaton = selectedMedication
        } else {
            (segue.destination as! MedicationDetailController).medicaton = Medication()
        }
        super.prepare(for: segue, sender: sender)
    }
    
    @IBAction func unwindToMedicationTableView(segue:UIStoryboardSegue) {
        let sourceVC = segue.source as! MedicationDetailController
        
        let medication = sourceVC.medicaton
        if let selectedIndexPath =  medicationTable.indexPathForSelectedRow {
            _medication[selectedIndexPath.row] = medication
            medicationTable.reloadRows(at: [selectedIndexPath], with: .fade)
        } else {
            let newIndexPath = IndexPath(row: _medication.count, section: 0)
            _medication.append(medication)
            medicationTable.insertRows(at: [newIndexPath], with: .automatic)
        }
        delegate?.onMedicationChanged(type: _medication)
    }
}
