//
//  MenuView.swift
//  festival-jeu
//
//  Created by ayoub moujane on 01/04/2021.
//

import SwiftUI

struct MenuView: View {
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                Image(systemName: "house")
                    .foregroundColor(.gray)
                    .imageScale(.large)
                Text("Accueil")
                    .foregroundColor(.gray)
                    .font(.headline)
            }
            .padding(.top,100)
            HStack{
                Image(systemName: "gamecontroller")
                    .foregroundColor(.gray)
                    .imageScale(.large)
                NavigationLink(destination: SearchJeuListView(searchJeuList: SearchJeuListViewModel(JeuList()))){
                    Text("Jeux")
                        .foregroundColor(.gray)
                        .font(.headline)
                }
            }
            .padding(.top,30)
            HStack{
                Image(systemName: "location")
                    .foregroundColor(.gray)
                    .imageScale(.large)
                Text("Zones")
                    .foregroundColor(.gray)
                    .font(.headline)
            }
            .padding(.top,30)
            HStack{
                Image(systemName: "person.crop.square")
                    .foregroundColor(.gray)
                    .imageScale(.large)
                Text("Exposants")
                    .foregroundColor(.gray)
                    .font(.headline)
            }
            .padding(.top,30)
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(red: 32/255, green: 32/255, blue: 32/255))
        .edgesIgnoringSafeArea(.all)
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
