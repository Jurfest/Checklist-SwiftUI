//
//  ChecklistItem.swift
//  Checklist
//
//  Created by Diego Jurfest Ceccon on 07/08/20.
//  Copyright © 2020 ___DIEGOJURFESTCECCON___. All rights reserved.
//

import Foundation

struct ChecklistItem: Identifiable {
    let id = UUID()
    var name: String
    var isChecked: Bool = false
}
