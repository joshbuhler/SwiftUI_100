//
//  CrewView.swift
//  Moonshot
//
//  Created by Joshua Buhler on 6/2/23.
//

import SwiftUI

struct CrewView: View {
    
    let crew:[MissionView.CrewMember]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack{
                ForEach(crew, id: \.role) { crewMember in
                    NavigationLink {
                        AstronautView(astronaut: crewMember.astronaut)
                    } label: {
                        HStack {
                            Image(crewMember.astronaut.id)
                                .resizable()
                                .frame(width: 104, height: 72)
                                .clipShape(Capsule())
                                .overlay(
                                    Capsule()
                                        .strokeBorder(.white, lineWidth: 1)
                                )
                            
                            VStack(alignment: .leading) {
                                Text(crewMember.astronaut.name)
                                    .foregroundColor(.white)
                                    .font(.headline)
                                Text(crewMember.role)
                                    .foregroundColor(.secondary)
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
        }
    }
}

struct CrewView_Previews: PreviewProvider {
    static var previews: some View {
        
        let crew = [MissionView.CrewMember(role: "Cap'n",
                                           astronaut: Astronaut(id: "1",
                                                                name: "Yondu",
                                                                description: "Mary Poppins")),
                    MissionView.CrewMember(role: "Mutineer",
                                                       astronaut: Astronaut(id: "8",
                                                                            name: "Tazerface",
                                                                            description: "Blah"))]
        
        CrewView(crew: crew)
            .preferredColorScheme(.dark)
    }
}
