//
//  ContentView.swift
//  UnitConversions
//
//  Created by Alonso Acosta Enriquez on 27/07/24.
//

import SwiftUI

struct ContentView: View {
    @State private var inputUnit = "days"
    @State private var outputUnit = "hours"
    @State private var time = 0.0
    
    let units = [
        "days",
        "hours",
        "minutes",
        "seconds",
    ]
    
    var conversion: Double {
        return convert(from: inputUnit, to: outputUnit, value: time)
    }
    
    var body: some View {
        Form {
            Section("Units") {
                Picker("From", selection: $inputUnit) {
                    ForEach(units, id: \.self) { unit in
                        Text("\(unit)")
                    }
                }
                .pickerStyle(.segmented)
                
                Picker("To", selection: $outputUnit) {
                    ForEach(units, id: \.self) { unit in
                        Text("\(unit)")
                    }
                }
                .pickerStyle(.segmented)
            }
            
            Section(inputUnit) {
                TextField("Time", value: $time, format: .number)
            }
            
            Section(outputUnit) {
                Text("\(conversion.formatted())")
            }
        }
    }
    
    func convert(from inputUnit: String, to outputUnit: String, value: Double) -> Double {
        if (inputUnit == outputUnit) {
            return value
        }
        
        guard let inputIndex = units.firstIndex(of: inputUnit), let outputIndex = units.firstIndex(of: outputUnit) else {
            return value
        }
        
        let convertDown = inputIndex - outputIndex < 0
        
        
        if (inputUnit == "days" && convertDown) {
            return convert(from: "hours", to: outputUnit, value: value * 24)
        }
        else if (inputUnit == "days" && convertDown == false) {
            return convert(from: "days", to: outputUnit, value: value)
        }
        
        else if (inputUnit == "hours" && convertDown) {
            return convert(from: "minutes", to: outputUnit, value: value * 60)
        }
        else if (inputUnit == "hours" && convertDown == false) {
            return convert(from: "days", to: outputUnit, value: value / 24)
        }
        
        else if (inputUnit == "minutes" && convertDown) {
            return convert(from: "seconds", to: outputUnit, value: value * 60)
        }
        else if (inputUnit == "minutes" && convertDown == false) {
            return convert(from: "hours", to: outputUnit, value: value / 60)
        }
        
        else if (inputUnit == "seconds" && convertDown) {
            return convert(from: "seconds", to: outputUnit, value: value)
        }
        else if (inputUnit == "seconds" && convertDown == false) {
            return convert(from: "minutes", to: outputUnit, value: value / 60)
        }
        
        return value
    }
}

#Preview {
    ContentView()
}
