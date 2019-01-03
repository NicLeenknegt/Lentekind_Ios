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
    @IBOutlet weak var allergyLbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        childNav.title = selectedChild.firstname + " " + selectedChild.lastname
        allergyLbl.text = selectedChild.allergies
        var indexPath = IndexPath(row: 0, section: 1)
        selectedChild.medication.forEach { med in
            let cell = childTable.cellForRow(at: indexPath)
            cell?.textLabel?.text = med.name + " : " + med.note
            indexPath.row += 1
            childTable.insertRows(at: [indexPath], with: .automatic)
        }
    }
    
}
