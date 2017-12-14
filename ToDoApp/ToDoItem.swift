//
//  ToDoItem.swift
//  ToDoApp
//
//  Created by Vandan Patel on 12/13/17.
//  Copyright © 2017 Vandan Patel. All rights reserved.
//

import Foundation

struct ToDoItem : Codable {
    var title: String
    var completed: Bool
    var createdAt: Date
    var itemIdentifier: UUID
    
    func saveItem() {
        DataManager.save(self, with: itemIdentifier.uuidString)
    }
    
    func deleteItem() {
        DataManager.delete(itemIdentifier.uuidString)
    }
    
    mutating func markAsCompleted() {
        self.completed = true
        DataManager.save(self, with: itemIdentifier.uuidString)
    }
}
