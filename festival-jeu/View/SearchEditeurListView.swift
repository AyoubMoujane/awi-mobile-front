//
//  SearchEditeurListView.swift
//  festival-jeu
//
//  Created by Pierre Perrin on 01/04/2021.
//

import SwiftUI

struct SearchEditeurListView: View {
    
    
    @ObservedObject var searchEditeurList : SearchEditeurListViewModel
    var intent : SearchEditeurListViewIntent
    
    init(searchEditeurList: SearchEditeurListViewModel){
        self.searchEditeurList = searchEditeurList
        self.intent = SearchEditeurListViewIntent(editeurList: searchEditeurList)
        let _  = self.searchEditeurList.$editeurListState.sink(receiveValue: stateChanged)
    }


    private var searchState : EditeurListState{
        return self.searchEditeurList.editeurListState
    }
    
    @State private var showModal      = false
    @State var detailPresented : Bool = false
    @State var revealSearchForm: Bool = false
    @State var textSearch             = ""
    
    /// Use to fake DetailView when displayed in DisclosureGroupe as DetailView need such bool when used in Modal view
    @State var dumbPresented : Bool = true
    
    
    var editeurs : [EditeurViewModel] {
        return self.searchEditeurList.editeurs
    }
    
    @State var text = ""
    
    func stateChanged(state: EditeurListState){
        switch state {
        case .newEditeurs:
            self.intent.editeurLoaded()
        default:
            break
        }
    }
    
    
    var body: some View {
        return NavigationView{
            VStack{
                SearchBar(text: $text)
                Text("Editeurs")
                Spacer()
            VStack{
                Button("Chercher editeurs"){
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
                    if (searchEditeurList.editeurs.count == 0) {
                        VStack{
                            Spacer()
                            Text("Pas d'éditeurs pour le festival courant")
                            Spacer()
                        }
                    } else {
                        
                        ForEach(searchEditeurList.editeurs.filter({
                            "\($0.name)".contains(text) || text.isEmpty
                        })) { editeur in
                                Text("\(editeur.name)")
                            }
                    }
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}


struct SearchEditeurListView_Previews: PreviewProvider {
    static var previews: some View {
        SearchEditeurListView(searchEditeurList: SearchEditeurListViewModel(EditeurList()))
    }
}
}
