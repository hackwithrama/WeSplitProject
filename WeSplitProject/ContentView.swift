//
//  ContentView.swift
//  WeSplitProject
//
//  Created by Ramachandran Varadaraju on 01/03/24.
//

import SwiftUI

struct ContentView: View {
    let tipPercentages = [0,10,15,20,25]
    
    @State private var tipPercentage = 15;
    @State private var amount: Double = 0
    @State private var totalPersons = 2
    @FocusState private var amountIsFocused: Bool
    
    var amountToBeShared: Double{
        let checkAmount = Double(amount)
        let totalPersonsToShare = Double(totalPersons + 2)
        let tipPercentageSelected = Double(tipPercentage)
        
        return (checkAmount / 100 * tipPercentageSelected + checkAmount) / totalPersonsToShare
    }
    
    var actualAmountWithTip: Double{
        let checkAmount = Double(amount)
        let tipPercentageSelected = Double(tipPercentage)
        
        return (checkAmount / 100 * tipPercentageSelected + checkAmount)
    }
    
    var body: some View {
        NavigationStack{
            Form{
                Section("Enter the amount and number of people"){
                    TextField("Enter the amount", value: $amount, format: .currency(code: "INR"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    Picker("Select number of people", selection: $totalPersons){
                        ForEach(2..<21){
                            Text("\($0) people")
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                .textCase(.none)
                
                
                Section("Select tip percentage"){
                    Picker("Tip percentage",selection: $tipPercentage){
                        ForEach(tipPercentages, id: \.self){
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                .textCase(.none)
                
                
                Section("Amount to be shared by per person"){
                    Text(amountToBeShared, format: .currency(code: "INR"))
                }
                .textCase(.none)
                .foregroundColor(.red)
                
                Section("Actual total amount"){
                    Text(actualAmountWithTip, format: .currency(code: "INR"))
                }
                .textCase(.none)
                
            }
            .navigationTitle("WeSplit")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                if amountIsFocused{
                    Button("Done"){
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
