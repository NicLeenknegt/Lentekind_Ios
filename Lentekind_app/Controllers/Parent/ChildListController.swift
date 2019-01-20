//
//  ChildListController.swift
//  Lentekind_app
//
//  Created by Nicolaas Leenknegt on 29/12/2018.
//  Copyright © 2018 Nicolaas Leenknegt. All rights reserved.
//
import UIKit

//source https://stackoverflow.com/questions/44595938/issue-in-long-press-gesture-recognizer

class ChildListController: UITableViewController {
    
    @IBOutlet var childrenTable: UITableView!
    var dataSelectedIndexPath:IndexPath = IndexPath()
    let parentService = AfParentService()
    var _children = [Child]()
    var selectedChild = Child()
    var newChild = true
    override func viewDidLoad() {
        super.viewDidLoad()
        parentService.getChildren() { (childrenCons, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                self._children = childrenCons.map { (con) -> Child in return con.child }
                self.tableView.reloadData()
            }
        }
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPress))
        self.view.addGestureRecognizer(longPressRecognizer)
    }
    
    @objc func longPress(sender: UILongPressGestureRecognizer) {
        
        if sender.state == UIGestureRecognizer.State.began {
            
            let touchPoint = sender.location(in: self.view)
            if let indexPath = tableView.indexPathForRow(at: touchPoint) {
                selectedChild = _children[indexPath.row]
                performSegue(withIdentifier: "DateSelectionSegue", sender: nil)
                dataSelectedIndexPath = indexPath
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return _children.count
        } else {
            return 0
        }
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = childrenTable.dequeueReusableCell(withIdentifier: "ChildCell", for: indexPath)
        let child = _children[indexPath.row]
        cell.textLabel?.text = child.firstname + " " + child.lastname
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedChild = _children[indexPath.row]
        performSegue(withIdentifier: "ChildDetailSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "ChildDetailSegue":
            let navController = segue.destination as! UINavigationController
            let destination = navController.topViewController as! ChildDetailViewController
            destination.child = selectedChild
        case "DateSelectionSegue":
            let dateNavController = segue.destination as! UINavigationController
            let destination = dateNavController.topViewController as! DateSelectionController
            destination.selectedDates = selectedChild._dates.map {  it in return it.date }
            destination.child_id = selectedChild._id
            
        default:
            return
        }
    }
    
    @IBAction func onNewClick(_ sender: Any) {
        selectedChild = Child()
        performSegue(withIdentifier: "ChildDetailSegue", sender: nil)
    }
    
    @IBAction func unwidToChildrenTableView(segue:UIStoryboardSegue) {
        guard segue.identifier == "SaveUnwind" else { return }
        let newChild = (segue.source as! ChildDetailViewController).child
        if let selectedIndexPath = childrenTable.indexPathForSelectedRow {
            if (self._children[selectedIndexPath.row] != newChild) {
                parentService.updateChild(child: newChild) { (message, error) in
                    if let error = error {
                        print(error.localizedDescription)
                    } else if let message = message {
                        print(message.message)
                        self._children[selectedIndexPath.row] = newChild
                        self.childrenTable.reloadRows(at: [selectedIndexPath], with: .automatic)
                    } else {
                        print("ERROR")
                    }
                }
            }
            print("update")
        } else {
            print("new")
            parentService.addChild(child: newChild) { (message, error) in
                if let error = error {
                    print(error.localizedDescription)
                } else if let message = message {
                    print(message.message)
                    let newIndexPath = IndexPath(row: self._children.count, section: 0)
                    self._children.append(newChild)
                    self.childrenTable.insertRows(at: [newIndexPath], with: .fade )
                } else {
                    print("ERROR")
                }
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            parentService.deleteChild(delete_id: _children[indexPath.row]._id) { (message, error) in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    self._children.remove(at: indexPath.row)
                    self.childrenTable.deleteRows(at: [indexPath], with: .fade)
                }
            }
        }
    }
    
    @IBAction func unwindToChildrenTableFromDateSelection(segue:UIStoryboardSegue) {
        guard segue.identifier == "SaveUnwind" else { return }
        let dates = (segue.source as! DateSelectionController).fsCalendar.selectedDates
        let dateObjects = dates.map { date in return DateObject(date: date, time: "full") }
        if (selectedChild.dates != dateObjects) {
            parentService.setDateOfChild(child_id: selectedChild._id, dateObjects: dateObjects) { (message, error) in
                if let error = error {
                    print(error.localizedDescription)
                } else if let message = message {
                    print(message.message)
                    self._children[self.dataSelectedIndexPath.row]._dates = dateObjects
                    self.childrenTable.reloadRows(at: [self.dataSelectedIndexPath], with: .automatic)
                }
            }
        }
    }
}

