//
//  Checklist.swift
//  Checklist
//
//  Created by Diego Jurfest Ceccon on 07/08/20.
//  Copyright © 2020 ___DIEGOJURFESTCECCON___. All rights reserved.
//

import Foundation

class Checklist: ObservableObject {
    
    // To start the app with an empty list when it is first launched in a device:
    // @Published var items: [ChecklistItem] = []
    
    @Published var items = [
        ChecklistItem(name: "Walk the dog"),
        ChecklistItem(name: "Brush my teeth"),
        ChecklistItem(name: "Learn iOS development", isChecked: true),
        ChecklistItem(name: "Soccer practice"),
        ChecklistItem(name: "Eat ice cream", isChecked: true),
    ]
    
    // Methods
    // =======
    
    init() {
        print("Documents directory is: \(documentsDirectory())")
        print("Data file path is: \(dataFilePath())")
        loadListItems()
    }
    
    func printChecklistContents() {
        for item in items {
            print(item)
        }
        print("===================")
    }
    
    func deleteListItem(whichElement: IndexSet) {
        items.remove(atOffsets: whichElement)
        printChecklistContents()
        saveListItems()
    }
    
    func moveListItem(whichElement: IndexSet, destination: Int) {
        items.move(fromOffsets: whichElement, toOffset: destination)
        printChecklistContents()
        saveListItems()
    }
    
    // MARK: - Data persistence
    
    // returns the location of the app’s Documents directory.
    func documentsDirectory() -> URL {
        // It does this by using the built-in FileManager.default object, which is the preferred way to access the file system in an app’s sandbox.
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        return paths[0]
    }
    
    // uses the result of documentsDirectory() to construct the full path to the file that will store the checklist items.
    func dataFilePath() -> URL {
        // This file is named Checklist.plist and it will live inside the Documents folder.
        return documentsDirectory().appendingPathComponent("Checklist.plist")
        
    }
    
    func saveListItems() {
        
        let encoder = PropertyListEncoder()
        
        // The do keyword is Swift’s way of catching errors that might come up when the program is running.
        do {
            // Here, you call the encoder’s encode() method to encode the items array. The method could fail. It throws an error if it’s unable to encode the data for some reason: Perhaps it’s not in the expected format, or it’s corrupted, or the device’s flash drive is unavailable.
            let data = try encoder.encode(items)
            try data.write(to: dataFilePath(), options: Data.WritingOptions.atomic)
            
        } catch {
            // if you have a catch block, Swift will automatically create a local variable named error
            print("Error encoding item array: \(error.localizedDescription)")
        }
        
    }
    
    func loadListItems() {
        
        let path = dataFilePath()
        
        if let data = try? Data(contentsOf: path) {
            
            //When the app does find a Checklist.plist file, the method creates an instance of PropertyListDecoder.
            let decoder = PropertyListDecoder()
            
            do {
                
                // The method loads the saved data back into items using the decoder’s decode method. The only item of interest here is the first parameter passed to decode . The decoder needs to know what type of data the result of the decode operation will be. You let it know that it will be an array of ChecklistItem objects.
                items = try decoder.decode([ChecklistItem].self, from: data)
                
            } catch {
                // code that executes if any line of code in the do block throws an error.
                print("Error decoding item array: \(error.localizedDescription)")
            }
        } else {
            print("No data is available yet.")
        }
    }
}
