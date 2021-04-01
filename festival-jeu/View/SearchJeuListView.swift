//
//  SearchJeuListView.swift
//  festival-jeu
//
//  Created by ayoub moujane on 23/03/2021.
//

import SwiftUI
import Foundation
import Combine

struct SearchJeuListView: View {
    
//    @EnvironmentObject var personalPlaylist : PersonalPlaylistViewModel
    
    /*
     * If searchPlaylist is initialized here, we must ensure that intent initialized here stays the same with the initial playlist
     * Else intent could manage another playlist if struct is reinit
     * The way to do that is a bit complicated but possible (see solution in comment below)
     * So the best is to pass searchPlaylist in parameter so, even if struct is reinit and intent recreated, it will manage the good searchplaylist
     *
    // MUST be a StateObject to stay the same and not being reallocated if struct is reinit
    @StateObject var searchPlaylist : SearchPlaylistViewModel
    // MUST be a StateObject to stay the same and not being reallocated if struct is reinit
    @StateObject var intent : SearchListViewIntent

    
    /// initialize view: create the search playlist and the intent of the view
    init(){
        let playlist    = SearchPlaylistViewModel(Playlist()) // create a searchList
        _searchPlaylist = StateObject(wrappedValue: playlist) // if searchPlaylist has already been allocated, this statement has no effect
        _intent         = StateObject(wrappedValue: SearchListViewIntent(playlist: playlist)) // same thing for intent
        // note : if intent whas not a StateObject, when struct is reallocated, a new intent is created with local playlist created here, and so
        // intent will no more manage the initial playlist!
    }
     */
    
    @ObservedObject var searchJeuList : SearchJeuListViewModel
    var intent : SearchJeuListViewIntent
    
    init(searchJeuList: SearchJeuListViewModel){
        self.searchJeuList = searchJeuList
        self.intent = SearchJeuListViewIntent(jeuList: searchJeuList)
        let _  = self.searchJeuList.$jeuListState.sink(receiveValue: stateChanged)
    }


    private var searchState : JeuListState{
        return self.searchJeuList.jeuListState
    }
    
    @State private var showModal      = false
    @State var detailPresented : Bool = false
    @State var revealSearchForm: Bool = false
    @State var textSearch             = ""
    
    /// Use to fake DetailView when displayed in DisclosureGroupe as DetailView need such bool when used in Modal view
    @State var dumbPresented : Bool = true
    
    
    var jeux : [JeuViewModel] {
        return self.searchJeuList.jeux
    }
    
    @State var text = ""
    
    func stateChanged(state: JeuListState){
        switch state {
        case .newJeux:
            self.intent.jeuLoaded()
        default:
            break
        }
    }
    
    var body: some View {
//        stateChanged(state: searchPlaylist.playListState)
        return NavigationView{
            VStack{
                SearchBar(text: $text)
                Text("Jeux")
                Spacer()
            VStack{
                Button("Chercher jeux"){
                    intent.loadData()
                }
                switch searchState{
                case .loading, .loaded:
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .green))
                        .scaleEffect(3)
                default:
                    EmptyView()
                }
                List {
                    if (searchJeuList.jeux.count == 0) {
                        VStack{
                            Spacer()
                            Text("Pas de jeux disponibles")
                            Spacer()
                        }
                    } else {
                        
                        ForEach(searchJeuList.jeux.filter({
                            "\($0.name)".contains(text) || text.isEmpty
                        })) { jeu in
                            NavigationLink(destination: JeuDetailView(jeuViewed: jeu)){
                                Text("\(jeu.name)")
                            }
                        }
                    }
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct SearchJeuListView_Previews: PreviewProvider {
    static var previews: some View {
        SearchJeuListView(searchJeuList: SearchJeuListViewModel(JeuList()))
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


