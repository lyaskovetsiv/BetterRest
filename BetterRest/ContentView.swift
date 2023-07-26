//
//  ContentView.swift
//  BetterRest
//
//  Created by Иван Лясковец on 24.07.2023.
//

import SwiftUI

struct ContentView: View {
	
	// MARK: - States
	
	@State private var wakeUp: Date = Date.now
	@State private var sleepAmount = 8.0
	@State private var coffeAmount = 1
	
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
