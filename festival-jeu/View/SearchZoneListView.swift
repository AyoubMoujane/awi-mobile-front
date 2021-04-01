//
//  SearchZoneListView.swift
//  festival-jeu
//
//  Created by ayoub moujane on 01/04/2021.
//

import SwiftUI
import Foundation
import Combine

struct SearchZoneListView: View {

    @ObservedObject var searchZoneList : SearchZoneListViewModel
    var intent : SearchZoneListViewIntent
    
    init(searchZoneList: SearchZoneListViewModel){
        self.searchZoneList = searchZoneList
        self.intent = SearchZoneListViewIntent(zoneList: searchZoneList)
        let _  = self.searchZoneList.$zoneListState.sink(receiveValue: stateChanged)
    }


    private var searchState : ZoneListState{
        return self.searchZoneList.zoneListState
    }
    
    @State private var showModal      = false
    @State var detailPresented : Bool = false
    @State var revealSearchForm: Bool = false
    @State var textSearch             = ""
    
    /// Use to fake DetailView when displayed in DisclosureGroupe as DetailView need such bool when used in Modal view
    @State var dumbPresented : Bool = true
    
    
    var zones : [ZoneViewModel] {
        return self.searchZoneList.zones
    }
    
    @State var text = ""
    
    func stateChanged(state: ZoneListState){
        switch state {
        case .newZones:
            self.intent.zoneLoaded()
        default:
            break
        }
    }
    
    var body: some View {
//        stateChanged(state: searchPlaylist.playListState)
        return NavigationView{
            VStack{
                SearchBar(text: $text)
                Text("Zones")
                Spacer()
            VStack{
                Button("Chercher zones"){
                    intent.loadData()
                }
                switch searchState{
                case .loading, .loaded:
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .green))
                        .scaleEffect(3)
                case .loadingError:
                    Text("Error")
                default:
                    EmptyView()
                }
                
                List {
                    if (searchZoneList.zones.count == 0) {
                        VStack{
                            Spacer()
                            Text("Pas de zones disponibles")
                            Spacer()
                        }
                    } else {
                        
                        ForEach(searchZoneList.zones.filter({
                            "\($0.name)".contains(text) || text.isEmpty
                        })) { jeu in
//                            NavigationLink(destination: JeuDetailView(jeuViewed: jeu)){
                                Text("\(jeu.name)")
//                            }
                        }
                    }
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct SearchZoneListView_Previews: PreviewProvider {
    static var previews: some View {
        SearchZoneListView(searchZoneList: SearchZoneListViewModel(ZoneList()) )
    }
}

//struct ListRow : View{
//    let track : TrackViewModel
//    var body: some View{
//        HStack{
//            track.image.smallSquare()
//            VStack(alignment: .leading){
//                if let name = track.name { Text(name).font(.title2) }
//                Text(track.album)
//                    .font(.headline)
//                Text(track.artist)
//            }
//        }
//    }
//}

//struct ErrorView : View{
//    let state : SearchPlayListState
//    var body: some View{
//        VStack{
//            Spacer()
//            switch state{
//            case .loading, .loaded:
//                ProgressView()
//                    .progressViewStyle(CircularProgressViewStyle(tint: .blue))
//                    .scaleEffect(3)
//            case .loadingError(let error):
//                ErrorMessage(error: error)
//            default:
//                EmptyView()
//            }
//            if case let .loaded(data) = state{
//                Text("\(data.count) tracks found!")
//            }
//            Spacer()
//        }
//    }
//}




//struct ErrorMessage : View{
//    let error :  Error
//    var body: some View{
//        VStack{
//            Text("Error in search request")
//                .errorStyle()
//            if let error = error  as? HttpRequestError {
//                Text("\(error.description)")
//                    .noteStyle()
//            }
//            else{
//                Text("Unknown error")
//                    .errorStyle()
//            }
//        }
//    }
}


