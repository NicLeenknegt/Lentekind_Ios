//
//  DateSelectionController.swift
//  Lentekind_app
//
//  Created by Nicolaas Leenknegt on 30/12/2018.
//  Copyright © 2018 Nicolaas Leenknegt. All rights reserved.
//

import UIKit
import FSCalendar

class DateSelectionController:UIViewController, FSCalendarDataSource, FSCalendarDelegate {
    
    @IBOutlet weak var fsCalendar: FSCalendar!
    var minDate:Date = Date()
    var maxDate:Date = Date()
    var selectedDates = [Date]()
    var child_id:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fsCalendar.dataSource = self
        fsCalendar.delegate = self
        fsCalendar.allowsMultipleSelection = true
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
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        selectedDates.forEach { date in
            fsCalendar.select(date)
        }
    }
    
    func minimumDate(for calendar: FSCalendar) -> Date {
        return minDate
    }
    
    func maximumDate(for calendar: FSCalendar) -> Date {
        return maxDate
    }
}
