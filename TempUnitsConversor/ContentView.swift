//
//  ContentView.swift
//  Temp Conversor
//
//  Created by Pablo Butron on 10/9/21.
//

import SwiftUI

struct ContentView: View {
    @State private var temperatureInput = ""
    @State private var temperatureInputType = 1
    @State private var temperatureoutputType = 1
    
    let measurementUnits = ["Celsius", "Fahrenheit", "Kelvin"]
    
    func celsiusToFahrenheit(temperatureInput: Double) -> Double {
        return (temperatureInput * (9/5)) + 32
    }
    func fahrenheitToCelsius(temperatureInput: Double) -> Double {
        return ((temperatureInput - 32) * (5/9))
    }
    
    var convertedValue: Double {
        let temperatureInputDouble = Double(temperatureInput) ?? 0
        
        //if no conversion needed, return temperatureInput
        if temperatureInputType == temperatureoutputType {
            return temperatureInputDouble
        }
        
        //Celsius to Fahrenheit
        if temperatureInputType == 0 && temperatureoutputType == 1 { return celsiusToFahrenheit(temperatureInput: temperatureInputDouble) }
        //Celsius to Kelvin
        if temperatureInputType == 0  && temperatureoutputType == 2 { return temperatureInputDouble + 273.15 }
        
        //Fahrenheit to Celsius
        if temperatureInputType == 1 && temperatureoutputType == 0 { return fahrenheitToCelsius(temperatureInput: temperatureInputDouble) }
        //Fahrenheit to Kelvin
        if temperatureInputType == 1 && temperatureoutputType == 2 { return fahrenheitToCelsius(temperatureInput: temperatureInputDouble) + 273.15 }
        
        //Kelvin to Celsius
        if temperatureInputType == 2 && temperatureoutputType == 0 { return temperatureInputDouble - 273.15 }
        //Kelvin to Fahrenheit
        if temperatureInputType == 2 && temperatureoutputType == 1 { return celsiusToFahrenheit(temperatureInput: temperatureInputDouble - 273.15) }
        
        return 0
    }
   
    var body: some View {
        NavigationView {
            Form {
                Section (header: Text ("Please put here the Temperature you want to convert")) {                    TextField("Temperature", text: $temperatureInput)
                        .keyboardType(.decimalPad)
                }
                
                Section (header: Text("Choose the units of the previous imput")) {
                    Picker("Unit", selection: $temperatureInputType) {
                        ForEach(0 ..< measurementUnits.count) {
                            Text("\(self.measurementUnits[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                Section (header:Text ("Plese select the desired temperature unit") ){
                    
                    Picker("Unit", selection: $temperatureoutputType) {
                        ForEach(0 ..< measurementUnits.count) {
                            Text("\(self.measurementUnits[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                    
                Section (header:Text ("\(temperatureInput) converted is ") ) {
                    Text("\(convertedValue, specifier: "%.2f")")
                }
            }
            .navigationBarTitle("Temperature Conversor")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
