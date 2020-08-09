//
//  ChecklistView.swift
//  Checklist
//
//  Created by Diego Jurfest Ceccon on 05/08/20.
//  Copyright © 2020 ___DIEGOJURFESTCECCON___. All rights reserved.
//

import SwiftUI


struct ChecklistView: View {
    
    
    
    //    var body: some View {
    //        NavigationView {
    //            List {
    //                Section(header: Text("High priority")) {
    //                    Group {
    //                        Text(checklistItems[0])
    //                        .onTapGesture {
    //                        self.checklistItems[0] = "Take the dog to the vet" }
    //                        Text(checklistItems[1])
    //                        Text(checklistItems[2])
    //                        Text(checklistItems[3])
    //                        Text(checklistItems[4])
    //                    }
    //                    Group {
    //                        Text("Finish homework")
    //                        Text("Change internet provider")
    //                        Text("Read RayWenderlich.com")
    //                        Text("Clean the kitchen")
    //                        Text("Wash the car")
    //                    }
    //
    //                }
    //                Section(header: Text("Low priority")) {
    //                    Text("Soccer practice")
    //                    Text("Eat ice cream")
    //                    Text("Record hit single")
    //                    Text("Learn every martial art")
    //                    Text("Design costume")
    //                    Text("Design crime-fighting vehicle")
    //                    Text("Come up with superhero name")
    //                    Text("Befriend space raccoon")
    //                    Text("Save the world")
    //                }
    //            }
    //            .listStyle(GroupedListStyle()) .navigationBarTitle("Checklist")
    //            List {
    //            Text("Nothing to see here...yet!")
    //            }
    //            .navigationBarTitle("Checklist") .onAppear() {
    //            self.printChecklistContents()
    //            }
    //        }
    //
    //    }
    
    @ObservedObject var checklist = Checklist()
    @State var newChecklistItemViewIsVisible = false
    
    //    var body: some View {
    //        NavigationView {
    //            List {
    //                ForEach(checklist.items, id: \.self.name) { checklistItem in
    //                    HStack {
    //                        Text(checklistItem.name)
    //                        Spacer()
    //                        Text(checklistItem.isChecked ? "✅":"🔲")
    //                    }
    //                        .background(Color.white) // This makes the entire row clickable
    //                        .onTapGesture {
    //                            if let matchingIndex = self.checklist.items.firstIndex(where: {
    //                                $0.id == checklistItem.id }) {
    //                                self.checklist.items[matchingIndex].isChecked.toggle()
    //                            }
    //                            self.checklist.printChecklistContents() }
    //                }
    //                .onDelete(perform: checklist.deleteListItem)
    //                .onMove(perform: checklist.moveListItem)
    //            }.navigationBarItems(
    //                leading: Button(action: { self.newChecklistItemViewIsVisible =
    //                true }) {
    //                    HStack {
    //                Image(systemName: "plus.circle.fill")
    //                      Text("Add item")
    //                    }
    //                },
    //                  trailing: EditButton()
    //            )
    //                .navigationBarTitle("Checklist", displayMode: .inline) .onAppear() {
    //                    self.checklist.printChecklistContents() }
    //        }
    //        .sheet(isPresented: $newChecklistItemViewIsVisible) {
    //          NewChecklistItemView(checklist: self.checklist)
    //        }
    
    var body: some View {
        NavigationView {
            List {
                // Cannot convert value of type '[ChecklistItem]' to expected argument type 'Range<Int>'
                 ForEach(checklist.items.indices, id: \.self) { index in
                     RowView(checklistItem: self.$checklist.items[index])
                 }
                    .onDelete(perform: checklist.deleteListItem)
                    .onMove(perform: checklist.moveListItem)
            }.navigationBarItems(
                leading: Button(action: { self.newChecklistItemViewIsVisible = true }) {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                        Text("Add item")
                    }
                },
                trailing: EditButton()
            )
                .navigationBarTitle("Checklist", displayMode: .inline) .onAppear() {
                    self.checklist.printChecklistContents() }
        }
        .sheet(isPresented: $newChecklistItemViewIsVisible) {
            NewChecklistItemView(checklist: self.checklist)
        }
        
    }
    
    // Methods
    // =======
    
}

// Preview
// =======

struct ChecklistView_Previews: PreviewProvider {
    static var previews: some View {
        ChecklistView()
    }
}
