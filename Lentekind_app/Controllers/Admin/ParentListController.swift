//
//  ParentListController.swift
//  Lentekind_app
//
//  Created by Nicolaas Leenknegt on 02/01/2019.
//  Copyright © 2019 Nicolaas Leenknegt. All rights reserved.
//

import UIKit

//source https://stackoverflow.com/questions/813068/uitableview-change-section-header-color
class ParentListController:UITableViewController, FilterDateDelegate,ParentDetailDelegate, UIGestureRecognizerDelegate {


    @IBOutlet weak var filterDateBtn: UIBarButtonItem!
    @IBOutlet var parentTable: UITableView!
    let adminService = AfAdminService()
    var _parents = [Parent]()
    var _filterParents = [Parent]()
    var minDate:Date = Date()
    var maxDate:Date = Date()
    var selectedDate = Date()
    var dateFormatter = DateFormatter()
    var selectedIndexPath:IndexPath = IndexPath()
    
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
        var filterIndex = 0
        for (index, parent) in _parents.enumerated() {
            var childArray = [ChildContainer]()
            if (parent.children.filter { c in c.child._dates.map{ d in self.dateFormatter.string(from: d.date) }.contains(dateString) }.count > 0) {
                _filterParents.append(parent)
                parent.children.forEach { con in
                    if (con.child._dates.map { d in self.dateFormatter.string(from: d.date) }.contains(dateString)) {
                        childArray.append(con)
                    }
                }
                _filterParents[filterIndex].children = childArray
                filterIndex += 1
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
        view.tintColor = _filterParents[section].paidDates.map { d in self.dateFormatter.string(from: d) }.contains(self.dateFormatter.string(from: selectedDate)) ? UIColor.green : UIColor.red
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
                destination.date = selectedDate
                destination.hasPaid = _filterParents[indexPath.section].paidDates.map { d in self.dateFormatter.string(from: d) }.contains(self.dateFormatter.string(from: selectedDate))
                destination.parent_id = _filterParents[indexPath.section]._id
                destination.delegate = self
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
    
    @IBAction func unwindToParentListTableView(segue:UIStoryboardSegue){
        let source = segue.source as! ParentDetailController
        
        if let selectedIndexPath = parentTable.indexPathForSelectedRow {
            let dateCheck = _filterParents[selectedIndexPath.section].paidDates.map { d in self.dateFormatter.string(from: d) }.contains(self.dateFormatter.string(from: source.date))
            var parent = _parents.filter { p in p._id == _filterParents[selectedIndexPath.section]._id }[0]
            if dateCheck {
                parent.paidDates = parent.paidDates.filter { d in
                    d != source.date
                }
                filterParents()
            }
        }
    }
    
    func setParentPaid(date: Date) {
        if let selectedIndexPath = parentTable.indexPathForSelectedRow {
            let parent = _parents.filter { p in p._id == _filterParents[selectedIndexPath.section]._id }[0]
            _parents[_parents.firstIndex(where: { $0 == parent}) ?? 0].paidDates.append(date)
            filterParents()
        }
    }
    
    func setParentUnPaid(date: Date) {
        if let selectedIndexPath = parentTable.indexPathForSelectedRow {
            let parent = _parents.filter { p in p._id == _filterParents[selectedIndexPath.section]._id }[0]
            _parents[_parents.firstIndex(where: { $0 == parent}) ?? 0].paidDates = _parents[_parents.firstIndex(where: { $0 == parent}) ?? 0].paidDates.filter { $0 != date }
            filterParents()
        }
    }
}
