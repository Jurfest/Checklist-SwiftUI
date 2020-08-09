//
//  RowView.swift
//  Checklist
//
//  Created by Diego Jurfest Ceccon on 09/08/20.
//  Copyright © 2020 ___DIEGOJURFESTCECCON___. All rights reserved.
//

import SwiftUI

struct RowView: View {
    
    // @State var checklistItem: ChecklistItem
    @Binding var checklistItem: ChecklistItem
    
    var body: some View {
        NavigationLink(destination: EditChecklistItemView(checklistItem: $checklistItem)) {
            HStack {
                Text(checklistItem.name)
                Spacer()
                Text(checklistItem.isChecked ? "✅":"🔲")
                
            }
        }
        
    }
}

struct RowView_Previews: PreviewProvider {
    static var previews: some View {
        RowView(checklistItem: .constant(ChecklistItem(name: "Sample item")))
    }
}
