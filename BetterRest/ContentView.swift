//
//  ContentView.swift
//  BetterRest
//
//  Created by Иван Лясковец on 24.07.2023.
//

import CoreML
import SwiftUI


struct ContentView: View {
	
	// MARK: - States
	
	@State private var wakeUp = defaultWakedTime
	@State private var sleepAmount = 8.0
	@State private var coffeeAmount = 1
	@State private var alertTitle = ""
	@State private var alertMessage = ""
	@State private var showingAlert = false
	
	// MARK: - Static properties
	
	static var defaultWakedTime: Date {
		var components = DateComponents()
		components.hour = 7
		components.minute = 0
		return Calendar.current.date(from: components) ?? Date.now
	}
	
	// MARK: - Private properties
	
	private var sleepTime: Date {
		return calculateBedTime()
	}
	
	// MARK: - UI
	
    var body: some View {
		NavigationView {
			VStack {
				Form {
					Section {
						DatePicker("Please enter a time",
								   selection: $wakeUp,
								   displayedComponents: DatePickerComponents.hourAndMinute)
						.labelsHidden()
					} header: {
						Text("When do you want to wake up?")
					}
					
					Section {
						Stepper("\(sleepAmount.formatted()) hours",
								value: $sleepAmount,
								in: 4...12,
								step: 0.25)
					} header: {
						Text("Desired amount of sleep")
					}
					
					Section {
						Picker(selection: $coffeeAmount) {
							ForEach(1..<12) { number in
								Text("\(number)")
							}
						} label: {
							Text("Coffee cups")
						}
					} header: {
						Text("Daily coffee intake")
					}
				}
				VStack {
					Text("Your better time to sleep")
					Text("\(sleepTime.formatted(date: .omitted, time: .shortened))")
						.font(.largeTitle)
				}
			}
			.navigationTitle("BetterRest")
		}
    }
	
	// MARK: - Private methods
	
	private func calculateBedTime() -> Date  {
		do {
			let config = MLModelConfiguration()
			let model = try SleepCalculator(configuration: config)
			
			let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
			let hour = (components.hour ?? 0) * 60 * 60
			let minute = (components.minute ?? 0) * 60
			
			let prediction = try model.prediction(wake: Double(hour+minute),
											  estimatedSleep: sleepAmount,
											  coffee: Double(coffeeAmount))
			let sleepTime = wakeUp - prediction.actualSleep
			return sleepTime
		} catch {
			alertTitle = "Error"
			alertMessage = "Sorry, we can't calculate yout bedtime"
			showingAlert = true
		}
		return Date.now
	}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
