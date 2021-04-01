//
//  ContentView.swift
//  festival-jeu
//
//  Created by ayoub moujane on 23/03/2021.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @State var results = JeuList()
    @State var showMenu = false

    var body: some View {
        
        let drag = DragGesture()
            .onEnded{
                if $0.translation.width < -100 {
                    withAnimation{
                        self.showMenu=false
                    }
                }
            }
        return NavigationView{
            GeometryReader { geometry in
                ZStack(alignment: .leading){
                    MainView(showMenu: self.$showMenu)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .offset(x:self.showMenu ? geometry.size.width/2:0)
                        .disabled(self.showMenu ? true: false)
                    if self.showMenu{
                        MenuView()
                            .frame(width: geometry.size.width/2)
                            .transition(.move(edge:.leading))
                    }
                }.gesture(drag)
            }
            .navigationBarTitle("Accueil", displayMode: .inline)
            .navigationBarItems(leading: (
                Button(action: {
                    withAnimation {
                        self.showMenu.toggle()
                    }
                }) {
                    Image(systemName: "line.horizontal.3")
                        .imageScale(.large)
                }
            ))
        }
        
    }
}
//        SearchJeuListView(searchJeuList: SearchJeuListViewModel(JeuList()))

struct MainView: View {
    
    @Binding var showMenu: Bool
    var body: some View {
        ZStack{
            Button(action: {
                withAnimation{
                    self.showMenu=true
                }
            }) {
                Image("logo-fjm").resizable().aspectRatio(contentMode: .fit).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            }
        }
    }
}
