//
//  ContentView.swift
//  Sundell.SwiftUILayout
//
//  Created by Josh Buhler on 3/3/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            EventHeader()
            Spacer()
        }
        .padding()
    }
}

extension View {
    func addVerifiedBadge (_ isVerified:Bool) -> some View {
        ZStack(alignment: .topTrailing) {
            self
            
            if (isVerified) {
                Image(systemName: "checkmark.circle.fill")
                    .offset(x: 3, y: -3)
            }
        }
    }
}

struct EventHeader:View {
    var body: some View {
        HStack(spacing: 15) {
            CalendarView()
            VStack(alignment: .leading) {
                Text("Event Title")
                    .font(.title)
                Text("Location")
            }
            .border(.green)
            Spacer()
        }
    }
}

struct CalendarView:View {
    var body: some View {
        Image(systemName: "calendar")
            .resizable()
            .frame(width: 50, height: 50)
            .padding()
            .background(.red)
            .cornerRadius(10)
            .foregroundColor(.white)
            .addVerifiedBadge(true)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
