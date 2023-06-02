//
//  ContentView.swift
//  Moonshot
//
//  Created by Joshua Buhler on 5/20/23.
//

import SwiftUI

struct User: Codable {
    let name: String
    let address: Address
}

struct Address: Codable {
    let street: String
    let city: String
}

struct ContentView: View {
    
    let astronauts:[String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions:[Mission] = Bundle.main.decode("missions.json")
    
    @State var showGrid = false
    
    var body: some View {
        NavigationView {
            Group {
                if (showGrid) {
                    MissionGrid(astronauts: astronauts,
                                missions: missions)
                    .padding([.horizontal, .vertical])
                } else {
                    MissionList(astronauts: astronauts,
                                missions: missions)
                }
            }
            .navigationTitle("Moonshot")
            .toolbar(content: {
                Button {
                    showGrid.toggle()
                } label: {
                    let icon = (showGrid) ? "rectangle.grid.1x2" : "square.grid.2x2"
                    Image(systemName: icon)
                }

            })
            .background(.darkBackground)
            .preferredColorScheme(.dark)
        }
    }
}

struct MissionGrid:View {
    
    let astronauts:[String:Astronaut]
    let missions:[Mission]
    
    let columns = [ GridItem(.adaptive(minimum: 150)) ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(missions) { mission in
                    NavigationLink {
                        MissionView(mission: mission,
                                    astronauts: astronauts)
                    } label: {
                        VStack {
                            Image(mission.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .padding()
                            
                            VStack {
                                Text(mission.displayName)
                                    .font(.headline)
                                    .foregroundColor(.white)
                                Text(mission.formattedLaunchDate)
                                    .font(.caption)
                                    .foregroundColor(.white.opacity(0.5))
                            }
                            .padding(.vertical)
                            .frame(maxWidth: .infinity)
                            .background(.lightBackground)
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.lightBackground)
                        }
                    }
                }
            }
        }
    }
}

struct MissionList:View {
    
    let astronauts:[String:Astronaut]
    let missions:[Mission]
        
    var body: some View {
        List {
            ForEach(missions) { mission in
                NavigationLink {
                    MissionView(mission: mission,
                                astronauts: astronauts)
                } label: {
                    VStack {
                        Image(mission.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .padding()
                        
                        VStack {
                            Text(mission.displayName)
                                .font(.headline)
                                .foregroundColor(.white)
                            Text(mission.formattedLaunchDate)
                                .font(.caption)
                                .foregroundColor(.white.opacity(0.5))
                        }
                        .padding(.vertical)
                        .frame(maxWidth: .infinity)
                        .background(.lightBackground)
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.lightBackground)
                    }
                }
            }
            .listRowBackground(Color.darkBackground)
            
        }
        .listStyle(.plain)
        
    }
}

struct CustomText: View {
    let text: String

    var body: some View {
        Text(text)
    }

    init(_ text: String) {
        print("CustomText \(text)")
        self.text = text
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
