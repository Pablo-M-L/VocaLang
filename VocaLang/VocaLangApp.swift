//
//  VocaLangApp.swift
//  VocaLang
//
//  Created by pablo millan lopez on 29/1/24.
//

import SwiftUI

@main
struct VocaLangApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(ViewModel())
        }
    }
}
