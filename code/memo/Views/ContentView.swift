//
//  ContentView.swift
//  ToDo
//
//  Created by eeee on 2023/2/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            ToDoListView()
            
            SOSButton()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ToDoListView: View {
    @StateObject var dataStore = DataStore()
    @State private var modelType: ModelType? = nil
    
    var body: some View {
        VStack {
            NavigationView {
                ZStack {
                    VStack {
                        List {
                            ForEach(dataStore.toDos) { toDo in
                                Button {
                                    modelType = .update(toDo)
                                } label: {
        
                                        ToDoBubble(toDo: toDo)
                                
                                }
                                
                            }
                            .onDelete(perform: dataStore.deleteToDo)
                        }
                        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
                        .listStyle(InsetGroupedListStyle())
                    }
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button {
                                modelType = .new
                            } label: {
                                Image(systemName: "plus.circle.fill")
                            }
                        }
                        
                    }
                    .navigationTitle("Today")
                    
                }
                .sheet(item: $modelType) { $0 }
                
            }
        }
    }
}
struct SOSButton: View {
    var phoneNumber = "10086"
    var body: some View {
        VStack {
            Spacer()
            Button {
                print("sos!!!!")
                let phone = "tel://"
                let phoneNumberformatted = phone + phoneNumber
                guard let url = URL(string: phoneNumberformatted) else { return }
                UIApplication.shared.open(url)
            } label: {
                Image("sos")
                    .resizable()
                    .frame(minWidth: 0, maxWidth: 80, minHeight: 0, maxHeight: 80)
                    .padding()
                    .clipShape(Circle())
            }
            .foregroundColor(.red)
        }
    }
}

