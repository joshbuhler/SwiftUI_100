//
//  AddView.swift
//  iExpense
//
//  Created by Joshua Buhler on 5/20/23.
//

import SwiftUI

struct AddView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var expenses:Expenses
    
    @State private var name = ""
    @State private var type:ExpenseType = .personal
    @State private var amount = 0.0
    
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                
                Picker("Type", selection: $type) {
                    ForEach(ExpenseType.allCases, id: \.self) {
                        Text($0.toString())
                    }
                }
                
                TextField("Amount",
                          value: $amount,
                          format: .currency(code: "USD"))
                    .keyboardType(.decimalPad)
            }
            .navigationTitle("Add new expense")
            .toolbar {
                Button ("Save") {
                    let newExpense = ExpenseItem(name: name,
                                                 type: type,
                                                 amount: amount)
                    expenses.items.append(newExpense)
                    dismiss()
                }
            }
        }
        
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
