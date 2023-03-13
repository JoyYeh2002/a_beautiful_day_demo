//
//  momoApp.swift
//  momo
//
//  Created by eeee on 2023/2/23.
//

import SwiftUI
import Firebase

@main
struct memoApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
