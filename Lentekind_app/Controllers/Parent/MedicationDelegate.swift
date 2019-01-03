//
//  MedicationDelegate.swift
//  Lentekind_app
//
//  Created by Nicolaas Leenknegt on 30/12/2018.
//  Copyright © 2018 Nicolaas Leenknegt. All rights reserved.
//

import Foundation

//source: https://learnappmaking.com/pass-data-between-view-controllers-swift-how-to/

protocol MedicationDelegate {
    func onMedicationChanged(type: [Medication])
}
