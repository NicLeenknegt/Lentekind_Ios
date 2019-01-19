//
//  ParentDetailController.swift
//  Lentekind_app
//
//  Created by Nicolaas Leenknegt on 02/01/2019.
//  Copyright © 2019 Nicolaas Leenknegt. All rights reserved.
//

import UIKit

//source: https://gist.github.com/nvkiet/e40b5b49fa3fd3c1952c
//source: https://stackoverflow.com/questions/18206448/how-can-i-get-the-height-of-a-specific-row-in-my-uitableview

class ParentDetailController:UITableViewController {
    
    @IBOutlet var childTable: UITableView!
    @IBOutlet weak var childNav: UINavigationItem!
    var selectedChild:Child = Child()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var contentOffset = childTable.contentOffset
        childNav.title = selectedChild.firstname + " " + selectedChild.lastname
        print(selectedChild.allergies)
        
        print(selectedChild.medication.count)
        var indexPath = IndexPath(row: 0, section: 1)
        childTable.beginUpdates()
        selectedChild.medication.forEach { med in
            print(med)
            let cell = childTable.cellForRow(at: indexPath)
            cell?.textLabel?.text = med.name + " : " + med.note
            contentOffset.y += cell?.fs_height ?? 0
            childTable.insertRows(at: [indexPath], with: .automatic)
            indexPath.row += 1
        }
        childTable.endUpdates()
        childTable.setContentOffset(contentOffset, animated: false)
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
