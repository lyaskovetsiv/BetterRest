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
	@State private var coffeeAmount = 1
	
    var body: some View {
		NavigationView {
			VStack {
				Text("When do you want to wake up?")
					.font(.headline)
				DatePicker("Please enter a time",
						   selection: $wakeUp,
						   displayedComponents: DatePickerComponents.hourAndMinute)
					.labelsHidden()
				
				Text("Desired amount of sleep")
					.font(.headline)
				Stepper("\(sleepAmount.formatted()) hours",
						value: $sleepAmount,
						in: 4...12,
						step: 0.25)
				
				Text("Daily coffee intake")
					.font(.headline)
				Stepper(coffeeAmount == 1 ? "1 cup" : "\(coffeeAmount) cups",
						value: $coffeeAmount,
						in: 1...20,
						step: 1)
			}
			.navigationTitle("BetterRest")
			.toolbar {
				Button("Calculate", action: calculateBedTime)
			}
		}
    }
	
	private func calculateBedTime() {
		
	}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
