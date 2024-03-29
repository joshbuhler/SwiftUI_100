//
//  ContentView.swift
//  iExpense
//
//  Created by Josh Buhler on 5/18/23.
//

import SwiftUI

struct ExpenseItem:Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: ExpenseType
    let amount: Double
}

enum ExpenseType:String, Codable, CaseIterable {
    case business
    case personal
    
    func toString () -> String {
        switch self {
        case .business:
            return "Business"
        case .personal:
            return "Personal"
        }
    }
}

class Expenses: ObservableObject {
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items"),
           let decodedItems = try? JSONDecoder().decode([ExpenseItem].self,
                                                        from: savedItems) {
            items = decodedItems
            return
        }
        
        items = []
    }
    
    @Published var items = [ExpenseItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
}

struct ExpenseRow: View {
    
    let item:ExpenseItem
    
    var body: some View {
        HStack {
            switch (item.type) {
            case .business:
                Image(systemName:"briefcase")
            case .personal:
                Image(systemName:"figure.wave")
            }
                
            Spacer()
            VStack(alignment: .leading) {
                Text(item.name)
                    .font(.headline)
                Text(item.type.toString())
            }
            Spacer()
            Text(item.amount, format: .currency(code: "USD"))
        }
    }
}


struct ContentView: View {
    
    @StateObject var expenses = Expenses()
    
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(expenses.items) { item in
                    ExpenseRow(item: item)
                }
                .onDelete(perform: removeItems)
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button {
                    showingAddExpense = true
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $showingAddExpense) {
            AddView(expenses: expenses)
        }
    }
    
    func removeItems(at offsets:IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
