//
//  ToDo.swift
//  ToDo
//
//  Created by eeee on 2023/2/24.
//

import Foundation

struct ToDo: Identifiable, Codable {
    var id: String = UUID().uuidString
    var name: String
    var completed: Bool = false
    var timestamp: Date
//    static var sampleData: [ToDo] {
//        [
//            ToDo(name: "go to supermarket", timestamp: Date()),
//            ToDo(name: "get up", completed: true, timestamp: Date())
//        ]
//    }
    
}
