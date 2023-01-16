//
//  ContentView.swift
//  converor
//
//  Created by Dennis Hazanovich on 2023-01-13.
//

import SwiftUI

struct ContentView: View {
    let units = ["meters", "kilometers", "feet", "yard", "miles"]
    @State private var selectedUnitsFrom: String = "feet"
    @State private var selectedUnitsTo: String = "feet"
    @State private var valueFrom:Double = 0
    @FocusState private var valueIsFocusted: Bool
    
    let conversionMatrix = ["meters-kilometers": 0.001,
                            "meters-feet": 3.28084,
                            "meters-yard": 1.09361,
                            "meters-miles": 0.00062136931818182,
                            "kilometers-meters": 1000.0,
                            "kilometers-feet": 3280.84,
                            "kilometers-yard": 1093.61,
                            "kilometers-miles": 0.62136931818182,
                            "feet-meters": 0.3048,
                            "feet-kilometers": 0.0003048,
                            "feet-yard": 0.333333,
                            "feet-miles": 0.00018939375,
                            "yard-meters": 0.9144,
                            "yard-kilometers": 0.0009144,
                            "yard-feet": 3.0,
                            "yard-miles": 0.000568182,
                            "miles-meters": 1609.34,
                            "miles-kilometers": 1.60934,
                            "miles-feet": 5280.0,
                            "miles-yard": 1760.0]
   
    var result:Double {
        var result:Double = 0
        if selectedUnitsFrom == selectedUnitsTo {
            result = valueFrom
        } else {
            result = valueFrom * (conversionMatrix["\(selectedUnitsFrom)-\(selectedUnitsTo)"] ?? 1.0)
        }
        return result
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Units to convert from", selection: $selectedUnitsFrom) {
                        ForEach(units, id: \.self) {
                            Text($0)
                        }
                    }.pickerStyle(.segmented)
                } header: {
                    Text("Select units to convert from")
                }
                
                Section {
                    Picker("Units to convert to", selection: $selectedUnitsTo) {
                        ForEach(units, id: \.self) {
                            Text($0)
                        }
                    }.pickerStyle(.segmented)
                } header: {
                    Text("Select units to convert to")
                }
                Section {
                    TextField("Value to convert", value: $valueFrom, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($valueIsFocusted)
                } header: {
                    Text("Value to convert")
                }
                
                Section {
                    Text("\(result.formatted()) \(selectedUnitsTo)")
                        .frame(maxWidth: .infinity, alignment: .center)
                } header: {
                    Text("Conversion result")
                }
            }.navigationTitle("iConvert")
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Spacer()
                        Button("Done") {
                            valueIsFocusted = false
                        }
                    }
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
