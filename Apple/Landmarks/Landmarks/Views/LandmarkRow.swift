//
//  LandmarkRow.swift
//  Landmarks
//
//  Created by Josh Buhler on 1/20/23.
//

import SwiftUI

struct LandmarkRow: View {
    
    var landmark:Landmark
    
    var body: some View {
        HStack {
            landmark.image
                .resizable()
                .frame(width: 50, height: 50)
            Text(landmark.name)
            
            Spacer()
        }
    }
}

struct LandmarkRow_Previews: PreviewProvider {
    static var previews: some View {
        // `landmarks` is a global defined in ModelData.swift
        LandmarkRow(landmark: landmarks[0])
    }
}
