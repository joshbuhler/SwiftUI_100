//
//  PageView.swift
//  Landmarks
//
//  Created by Josh Buhler on 1/26/23.
//

import SwiftUI

struct PageView<Page: View>: View {
    var pages:[Page]
    @State private var currentPage = 0
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            PageViewController(pages: pages, currentPage: $currentPage)
            PageControl(numberOfPages: pages.count, currentPage: $currentPage)
                .frame(width: CGFloat(pages.count * 18))
                .padding(.trailing)
        }
        
        //        VStack {
        //            PageViewController(pages: pages, currentPage: $currentPage)
        //            Spacer()
        //            Text("Current Page: \(currentPage)")
        //            Spacer()
        //            HStack {
        //                Button("Previous Page") {
        //                    if (currentPage > 0) {
        //                        currentPage -= 1
        //                    }
        //                }
        //                Button("Next Page") {
        //                    if (currentPage < (pages.count - 1)) {
        //                        currentPage += 1
        //                    }
        //                }
        //            }
        //        }
    }
}

struct PageView_Previews: PreviewProvider {
    static var previews: some View {
        PageView(pages: ModelData().features.map { FeatureCard(landmark: $0) })
            .aspectRatio(3/2, contentMode: .fit)
    }
}
