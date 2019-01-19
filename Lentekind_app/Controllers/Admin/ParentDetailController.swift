//
//  ParentDetailController.swift
//  Lentekind_app
//
//  Created by Nicolaas Leenknegt on 02/01/2019.
//  Copyright © 2019 Nicolaas Leenknegt. All rights reserved.
//

import UIKit

class ParentDetailController:UITableViewController {
    
    @IBOutlet var childTable: UITableView!
    @IBOutlet weak var childNav: UINavigationItem!
    var selectedChild:Child = Child()
    var date:Date = Date()
    var hasPaid:Bool = false
    let adminService = AfAdminService()
    var parent_id:String = "";
    var delegate:ParentDetailDelegate? = nil
    @IBOutlet weak var paidDateBtn: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        childNav.title = selectedChild.firstname + " " + selectedChild.lastname
        paidDateBtn.title = hasPaid ? "Betaald" : "Niet betaald"
    }

    @IBAction func onPaidClick(_ sender: Any) {
        paidDateBtn.isEnabled = false
        switch paidDateBtn.title {
        case "Betaald":
            adminService.setParentUnPaid(parent_Id: parent_id, date: date) { (message, error) in
                if error != nil {
                    self.paidDateBtn.title = "Betaald"
                    self.paidDateBtn.isEnabled = true
                } else {
                    self.paidDateBtn.title = "Niet betaald"
                    self.delegate?.setParentUnPaid(date: self.date)
                    self.paidDateBtn.isEnabled = true
                }
            }
            break
        case "Niet betaald":
            adminService.setParentPaid(parent_Id: parent_id, date: date) { (message, error) in
                if error != nil {
                    self.paidDateBtn.title = "Niet betaald"
                    self.paidDateBtn.isEnabled = true
                } else {
                    self.paidDateBtn.title = "Betaald"
                    self.delegate?.setParentPaid(date: self.date)
                    self.paidDateBtn.isEnabled = true
                }
            }
            break
        default: break
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 1 ? 1 : selectedChild.medication.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = childTable.dequeueReusableCell(withIdentifier: "DetailCell", for: indexPath)
        switch indexPath.section {
        case 0:
            cell.textLabel?.text = selectedChild.allergies
            break
        default:
            if (!selectedChild.medication.isEmpty){
                let med = selectedChild.medication[indexPath.row]
                cell.textLabel?.text = med.name + " : " + med.note
            }
            
            break
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Allergieën"
        case 1:
            if (selectedChild.medication.count > 0) {
                return "Medicatie"
            }
        default:
            return ""
        }
       return ""
    }
}
