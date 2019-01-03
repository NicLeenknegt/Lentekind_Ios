//
//  FilterDateDelegate.swift
//  Lentekind_app
//
//  Created by Nicolaas Leenknegt on 02/01/2019.
//  Copyright © 2019 Nicolaas Leenknegt. All rights reserved.
//

import Foundation

//source: https://learnappmaking.com/pass-data-between-view-controllers-swift-how-to/

protocol FilterDateDelegate {
    func onFilterDateChanged(date:Date)
}
