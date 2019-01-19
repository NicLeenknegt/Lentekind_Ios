//
//  ParentListController.swift
//  Lentekind_app
//
//  Created by Nicolaas Leenknegt on 02/01/2019.
//  Copyright © 2019 Nicolaas Leenknegt. All rights reserved.
//

import UIKit

//source https://stackoverflow.com/questions/813068/uitableview-change-section-header-color
class ParentListController:UITableViewController, FilterDateDelegate, UIGestureRecognizerDelegate {

    @IBOutlet weak var filterDateBtn: UIBarButtonItem!
    @IBOutlet var parentTable: UITableView!
    let adminService = AfAdminService()
    var _parents = [Parent]()
    var _filterParents = [Parent]()
    var minDate:Date = Date()
    var maxDate:Date = Date()
    var selectedDate = Date()
    var dateFormatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPress))
        self.view.addGestureRecognizer(longPressRecognizer)
        
        dateFormatter.dateFormat = "dd/MM/YYYY"
        let date:Date = Date()
        let calendar = Calendar.current
        var year:Int = calendar.component(.year, from: date)
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = 8
        dateComponents.day = 31
        maxDate = calendar.date(from: dateComponents) ?? Date()
        minDate = Date()
        if date > maxDate {
            year = year + 1
            dateComponents.year = year
            maxDate = calendar.date(from: dateComponents) ?? Date()
        }
        dateComponents.month = 7
        dateComponents.day = 1
        minDate = calendar.date(from: dateComponents) ?? Date()
        selectedDate = minDate
        filterDateBtn.title = dateFormatter.string(from: selectedDate)
        adminService.getParents() { (parents, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                self._parents = parents
                self.filterParents()
            }
            
        }
    }
    
    @objc func longPress(sender: UILongPressGestureRecognizer) {
        
        if sender.state == UIGestureRecognizer.State.began {
            
            let touchPoint = sender.location(in: self.view)
            if let indexPath = parentTable.indexPathForRow(at: touchPoint) {
                
            }
        }
    }
    
    func filterParents() {
        _filterParents = []
        let dateString = self.dateFormatter.string(from: selectedDate)
        for (index, parent) in _parents.enumerated() {
            var childArray = [ChildContainer]()
            if (parent.children.filter { c in c.child._dates.map{ d in self.dateFormatter.string(from: d.date) }.contains(dateString) }.count > 0) {
                _filterParents.append(parent)
                parent.children.forEach { con in
                    if (con.child._dates.map { d in self.dateFormatter.string(from: d.date) }.contains(dateString)) {
                        childArray.append(con)
                    }
                }
                _filterParents[index].children = childArray
            }
        }
        self.parentTable.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ChildDetailSegue", sender: nil)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return _filterParents.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _filterParents[section].children.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = parentTable.dequeueReusableCell(withIdentifier: "ParentCell", for: indexPath)
        let child = _filterParents[indexPath.section].children[indexPath.row].child
        cell.textLabel?.text = child.firstname + " " + child.lastname
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = _parents[section].paidDates.map { d in self.dateFormatter.string(from: d) }.contains(self.dateFormatter.string(from: selectedDate)) ? UIColor.green : UIColor.red
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.white
    }

    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let parent = _filterParents[section]
        return parent.firstname + " " + parent.lastname
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "FilterDateSegue":
            let destination = segue.destination as! FilterDateController
            destination.delegate = self
            destination.minDate = minDate
            destination.maxDate = maxDate
            destination.selectedDate = selectedDate
            return
        case "ChildDetailSegue":
            if let indexPath = parentTable.indexPathForSelectedRow {
                let destination = segue.destination as! ParentDetailController
                destination.selectedChild = _filterParents[indexPath.section].children[indexPath.row].child
            }
            
        default:
            return
        }
    }
    
    func onFilterDateChanged(date: Date) {
        selectedDate = date
        filterDateBtn.title = dateFormatter.string(from: selectedDate)
        self.filterParents()
    }
}
