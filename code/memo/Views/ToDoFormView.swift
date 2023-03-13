//
//  ToDoFormView.swift
//  ToDo
//
//  Created by eeee on 2023/2/24.
//

import SwiftUI

struct ToDoFormView: View {
    @StateObject var dataStore = DataStore()
    @ObservedObject var formVM: ToDoFormViewModel
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        NavigationView {
            Form {
                VStack(alignment: .leading) {
                    TextField("ToDo", text: $formVM.name)
                    Toggle("Completed", isOn: $formVM.completed)
                }
            }
            .navigationTitle("ToDo")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading: cancelButton, trailing: updateSaveButton)
        }
        
    }
}

extension ToDoFormView {
    func updateToDo() {
        let toDo = ToDo(id: formVM.id!, name: formVM.name, completed: formVM.completed, timestamp: formVM.date)
//        print("todo:\(toDo)")
        dataStore.updateToDo(toDo)
        presentationMode.wrappedValue.dismiss()
    }
    
    func addToDo() {
        let toDo = ToDo(name: formVM.name, timestamp: formVM.date)
        dataStore.addToDo(toDo)
        presentationMode.wrappedValue.dismiss()
    }
    
    var cancelButton: some View {
        Button("Cancel") {
            presentationMode.wrappedValue.dismiss()
        }
        
    }
    var updateSaveButton: some View {
        Button( formVM.updating ? "Update" : "Save", action: formVM.updating ? updateToDo : addToDo)
            .disabled(formVM.isDisabled)
    }
    
}

struct ToDoFormView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoFormView(formVM: ToDoFormViewModel())
            .environmentObject(DataStore())
    }
}
