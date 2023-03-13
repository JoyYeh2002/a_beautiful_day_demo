//
//  ToDoFormViewModel.swift
//  ToDo
//
//  Created by eeee on 2023/2/24.
//

import Foundation

class ToDoFormViewModel: ObservableObject {
    @Published var name = ""
    @Published var completed = false
    @Published var date = Date()
    var id: String?
    
    var updating: Bool {
        id != nil
    }
    
    var isDisabled: Bool {
        name.isEmpty
    }
    
    init() {}
    
    init(_ currentToDo: ToDo) {
        self.name = currentToDo.name
        self.completed = currentToDo.completed
        self.date = currentToDo.timestamp
        id = currentToDo.id
    }
    
}
