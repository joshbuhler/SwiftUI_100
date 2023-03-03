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
            .frame(width: 300, height: 300)
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

struct UnitDeployment:View {
    var body: some View {
        //        GeometryReader() { geo in
        //            VStack{
        //                HStack{
        //                    UnitCard()
        //                        .frame(width: geo.size.width * 0.67)
        //                    UpgradeCard()
        //                        .frame(width: geo.size.width * 0.33)
        //                    //                        .fixedSize(horizontal: false, vertical: true)
        //                    //                    .rotationEffect(Angle(degrees: 90))
        //                }
        //
        //                .border(Color.gray)
        //                HStack{
        //                    UpgradeCard()
        //                        .frame(width: geo.size.width * 0.33)
        //                    UpgradeCard()
        //                        .frame(width: geo.size.width * 0.33)
        //                    UpgradeCard()
        //                        .frame(width: geo.size.width * 0.33)
        //                }
        //            }
        //        }
        //        .frame(width: 200)
        //        .border(Color.green)
        
        VStack () {
            GeometryReader { geo in
                HStack {
                    UnitCard()
                    UpgradeCard()
                }
                .frame(height: geo.size.height * 0.5)
                .border(.blue)
                HStack{
                    UpgradeCard()
                    UpgradeCard()
                    UpgradeCard()
                }
                .border(.red)
            }
        }
        .border(.green)
    }
}

struct UnitCard:View {
    var body: some View {
        Color.orange
            .opacity(0.5)
            .aspectRatio(88/61, contentMode: .fit)
        //            .frame(idealHeight: 200)
            .background(.gray)
    }
}

struct UpgradeCard:View {
    var body: some View {
        Color.blue
            .opacity(0.25)
            .aspectRatio(61/88, contentMode: .fit)
        //            .frame(idealHeight: 200)
            .background(.gray)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
