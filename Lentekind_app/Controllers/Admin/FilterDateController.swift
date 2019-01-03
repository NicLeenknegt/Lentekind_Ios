//
//  FilterDateController.swift
//  Lentekind_app
//
//  Created by Nicolaas Leenknegt on 02/01/2019.
//  Copyright © 2019 Nicolaas Leenknegt. All rights reserved.
//

import UIKit
import FSCalendar

class FilterDateController: UIViewController, FSCalendarDataSource, FSCalendarDelegate {
    
    @IBOutlet weak var fsCalendar: FSCalendar!
    var minDate:Date = Date()
    var maxDate:Date = Date()
    var selectedDate:Date = Date()
    var delegate:FilterDateDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fsCalendar.dataSource = self
        fsCalendar.delegate = self
        fsCalendar.select(selectedDate)
    }
    
    func minimumDate(for calendar: FSCalendar) -> Date {
        return minDate
    }
    
    func maximumDate(for calendar: FSCalendar) -> Date {
        return maxDate
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        delegate?.onFilterDateChanged(date: date)
    }
}
