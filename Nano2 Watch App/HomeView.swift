//
//  ContentView.swift
//  Nano2 Watch App
//
//  Created by Geraldy Kumara on 19/05/23.
//

import SwiftUI

struct HomeView: View {
    
    var body: some View {
        NavigationStack{
            VStack{
                Text("Welcome to Meditcus 🔆")
                    .font(.system(size: 14))
                ScrollView(.vertical){
                    Text("Meditcus is an application that is useful for monitoring your heart rate while doing meditation and will do a reminder if you are not focused which can be seen from your rising heart rate")
                        .font(.system(size: 10.5))
                        .padding(EdgeInsets(top: 10,
                                            leading: 10,
                                            bottom: 0,
                                            trailing: 10))
                }

                Spacer()
                NavigationLink() {
                    MeditationView()
                } label: {
                    ButtonView(title: ("Start"), width: 155)
                }
                .frame(width: 155, height: 30)
                .cornerRadius(8)
                .padding(.bottom, -20)
            }
            .padding()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
