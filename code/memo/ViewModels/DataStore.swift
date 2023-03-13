//
//  DataStore.swift
//  ToDo
//
//  Created by eeee on 2023/2/24.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class DataStore: ObservableObject {
    @Published var toDos: [ToDo] = []
    @Published private(set) var lastToDoId: String = ""
    
    let db = Firestore.firestore()
    
    
    init() {
        
        loadToDos()
    }
    
    
    func addToDo(_ todo: ToDo) {
        toDos.append(todo)
        sendToDo(name: todo.name)
    }
    
    func updateToDo(_ todo: ToDo) {
        guard let index = toDos.firstIndex(where: { $0.id == todo.id}) else { return }
        toDos[index] = todo
        
        db.collection("memo").document(todo.id).updateData(["name": todo.name, "completed": todo.completed])
        
        
    }
    
    func deleteToDo(at indexSet: IndexSet) {
        toDos.remove(atOffsets: indexSet)
        
    }
    
    func loadToDos() {
        getToDo()
    }
    
    func saveToDos() {
        print("saving toDos to file")
    }
    
    func getToDo() {
        db.collection("memo").addSnapshotListener { querySnapshot, error in
            guard let documents = querySnapshot?.documents else {
                print("Error fetching documents: \(String(describing: error))")
                return
            }
            
            self.toDos = documents.compactMap { document -> ToDo? in
                do {
                    return try document.data(as: ToDo.self)
                } catch {
                    print("Error decoding document into Message: \(error)")
                    
                    // Return nil if we run into an error - but the compactMap will not include it in the final array
                    return nil
                }
                
            }
            
            self.toDos.sort { $0.timestamp < $1.timestamp }
            // Getting the ID of the last message so we automatically scroll to it in ContentView
            if let id = self.toDos.last?.id {
                self.lastToDoId = id
                
            }
            
        }
    }
    
    func sendToDo(name: String) {
        do {
            
            let newToDo = ToDo(id: "\(UUID())", name: name, timestamp: Date())
            try db.collection("memo").document().setData(from: newToDo)
            
        } catch {
            
            print("Error adding message to Firestore: \(error)")
            
        }
    }
    
    
    
}
