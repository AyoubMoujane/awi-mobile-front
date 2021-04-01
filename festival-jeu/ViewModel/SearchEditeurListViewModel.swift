//
//  SearchEditeurListViewModel.swift
//  festival-jeu
//
//  Created by Pierre Perrin on 01/04/2021.
//

import Foundation

import Foundation
import SwiftUI
import Combine

enum EditeurListState : CustomStringConvertible{
    case ready
    case loading(String)
    case loaded([Editeur])
    case loadingError(Error)
    case newEditeurs([EditeurViewModel])

    var description: String{
        switch self {
        case .ready                               : return "ready"
        case .loading(let s)                      : return "loading: \(s)"
        case .loaded(let editeurs)                  : return "loaded: \(editeurs.count) editors"
        case .loadingError(let error)             : return "loadingError: Error loading -> \(error)"
        case .newEditeurs(let editeurs)               : return "newJeu: reset game list with \(editeurs.count) editors"
        }
    }
    
}


class SearchEditeurListViewModel:  EditeurListDelegate, ObservableObject{
    
    /// Playlist model of ViewModel
    private(set) var model: EditeurList
    
    @Published private(set) var editeurs = [EditeurViewModel]()

    /// State of new data loading
    @Published var editeurListState : EditeurListState = .ready{
        didSet{
            switch self.editeurListState { // state has changed
            case let .loaded(data):    // new data has been loaded, to change all games of list
                let sortedData = data.sorted(by: { $0.name < $1.name })
                new(editeurs: sortedData)
            default:                   // nothing to do for ViewModel, perhaps for the view
                return
            }
        }
    }
    
    /// initialization
    /// - Parameter editeurList: editeurlist model to be the ViewModel
    init(_ editeurList: EditeurList){
        self.model = editeurList
        self.model.delegate = self
    }
    
    /// new list of editors for the list
    /// - Parameter editors: editors that will compose the list
    func new(editeurs: [Editeur]){
        self.model.new(editeurs: editeurs)
    }
    
    /// called when editeurlist model has changed all its list of games
    func newEditeurList() {
        #if DEBUG
        debugPrint("SearchJlvm: newEditeurList()")
        #endif
        self.editeurs.removeAll()
        for editeur in self.model.editeurs{
            self.editeurs.append(EditeurViewModel(editeur))
        }
        #if DEBUG
        debugPrint("SearchJlvm: editeurListState = .newEditeurs")
        #endif
        self.editeurListState = .newEditeurs(self.editeurs)
    }
    
}
