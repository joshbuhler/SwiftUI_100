//
//  ContentView.swift
//  GeoReader
//
//  Created by Josh Buhler on 2/28/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        //        GeometryReader { geeometry in
        //            HStack(spacing: 0) {
        //                Text ("Left")
        //                    .font(.largeTitle)
        //                    .foregroundColor(.black)
        //                    .aspectRatio(88/61, contentMode: .fill)
        //                    .frame(width: geeometry.size.width * 0.33, height: geeometry.size.height)
        //                    .background(.yellow)
        //                Text ("Right")
        //                    .font(.largeTitle)
        //                    .foregroundColor(.black)
        //                    .frame(width: geeometry.size.width * 0.67)
        //                    .background(.orange)
        //            }
        //        }
        CardGroup()
    }
}

struct CardGroup:View {
    var body: some View {
        //        GeometryReader { geo in
        //        HStack () {
        //                Color.orange
        //                .frame(idealHeight: 100)
        ////                    .aspectRatio(88/61, contentMode: .fit)
        ////                                .frame(maxHeight: .infinity)
        //                Spacer()
        //                Color.blue
        ////                    .aspectRatio(61/88, contentMode: .fit)
        ////                    .frame(maxHeight: geo.size.height)
        //            }
        //            .background(.gray)
        //        }
        ////        .frame(height: 200)
        ////        .fixedSize(horizontal: false, vertical: true)
        //        .background(.green)
        
        //    }
        //        VStack {
        //            UnitDeployment()
        UnitDeployment()
            .frame(height: 200)
        //        }
    }
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
        
        VStack {
            HStack {
                UnitCard()
                UpgradeCard()
            }
            .border(.blue)
            HStack {
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
