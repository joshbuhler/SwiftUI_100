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
            EventInfoList()
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
    
    func syncingHeightIfLarger(than height:Binding<CGFloat?>) -> some View {
        background(GeometryReader { proxy in
            Color.clear.preference(key: HeightPreferenceKey.self,
                                   value: proxy.size.height)
        })
        .onPreferenceChange(HeightPreferenceKey.self) {
            height.wrappedValue = max(height.wrappedValue ?? 0, $0)
        }
    }
}

private struct HeightPreferenceKey:PreferenceKey {
    static let defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

struct HeightSyncedRow<Background:View, Content:View>:View {
    private let background:Background
    private let content:Content
    @State private var childHeight:CGFloat?
    
    init(background:Background, @ViewBuilder content: () -> Content) {
        self.background = background
        self.content = content()
    }
    
    var body: some View {
        HStack {
            content.syncingHeightIfLarger(than: $childHeight)
                .frame(height:childHeight)
                .background(background)
//                .border(.red)
        }
    }
}

struct EventInfoList:View {
    var body: some View {
        HeightSyncedRow(background: Color.secondary.cornerRadius(10)) {
            EventInfoBadge(iconName: "video.circle.fill",
                           text: "Video call available")
            EventInfoBadge(iconName: "doc.text.fill",
                           text: "Files are attached")
            EventInfoBadge(iconName: "person.crop.circle.badge.plus",
                           text: "Invites allowed")
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

struct EventInfoBadge:View {
    var iconName:String
    var text:String
    
    var body: some View {
        VStack {
            Image(systemName: iconName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 25, height: 25)
            Text(text)
                .frame(maxWidth: .infinity)
                .multilineTextAlignment(.center)
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 5)
        .cornerRadius(10)
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
