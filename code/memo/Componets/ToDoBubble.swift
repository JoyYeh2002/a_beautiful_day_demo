//
//  ToDoBubble.swift
//  ToDo
//
//  Created by eeee on 2023/2/24.
//

import SwiftUI

struct ToDoBubble: View {
    var toDo: ToDo
    
    var body: some View {

        VStack(alignment: .leading) {
            Text("\(toDo.name)")
                .font(.largeTitle)
                .strikethrough(toDo.completed)
                .foregroundColor(toDo.completed ? .green : Color(.label))
                .padding(3)
            Text(toDo.timestamp.formattedString("MM/dd  HH:mm"))
                .font(.title2)
                .padding(3)
        }
        .padding(.horizontal)
    }
}

extension Date {
    func formattedString(_ format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}

struct ToDoBubble_Previews: PreviewProvider {
    static var previews: some View {
        ToDoBubble(toDo: ToDo(name: "get groceries", timestamp: Date()))
    }
}
