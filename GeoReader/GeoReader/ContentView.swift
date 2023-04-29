//
//  ContentView.swift
//  GeoReader
//
//  Created by Josh Buhler on 2/28/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        CardGroup()
    }
}

struct CardGroup:View {
    var body: some View {
        
        UnitDeployment()
        //                    .fixedSize(horizontal: true, vertical: false)
            .frame(width: 325, height: 250)
            .border(.orange)
    }
        //        TabView {
        //            UnitDeployment()
        //            UnitDeployment()
        //            UnitDeployment()
        //            UnitDeployment()
        //        }
        //        .tabViewStyle(.page(indexDisplayMode: .always))
        //        .indexViewStyle(.page(backgroundDisplayMode: .always))
        //        .frame(height: 200)
        //        }
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

struct UnitDeployment:View {
    var body: some View {
        
        VStack () {
            HeightSyncedRow(background: Color.red) {
                UnitCard().layoutPriority(1)
                UpgradeCard()
            }
            .border(.blue)
            HeightSyncedRow(background: Color.red){
                UpgradeCard()
                UpgradeCard()
                UpgradeCard()
            }
            .border(.red)
        }
        .border(.green)
    }
}

struct UnitCard:View {
    var body: some View {
        Color.orange
            .opacity(0.5)
            .aspectRatio(88/61, contentMode: .fit)
//            .frame(maxWidth: .infinity)
        //            .frame(idealHeight: 200)
            .background(.gray)
    }
}

struct UpgradeCard:View {
    var body: some View {
        Color.blue
            .opacity(0.25)
            .aspectRatio(61/88, contentMode: .fit)
            .frame(maxHeight: .infinity)
        //            .frame(idealHeight: 200)
//            .background(.gray)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
