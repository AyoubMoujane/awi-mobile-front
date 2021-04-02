//
//  SearchEditeurListViewIntent.swift
//  festival-jeu
//
//  Created by Pierre Perrin on 01/04/2021.
//


import Foundation
import SwiftUI



class SearchEditeurListViewIntent{
    
    @ObservedObject var editeurList : SearchEditeurListViewModel
    
    init(editeurList: SearchEditeurListViewModel){
        self.editeurList = editeurList
    }
        
    func loaded(editeurs: [Editeur]){
        #if DEBUG
        debugPrint("SearchIntent: \(self.editeurList.editeurListState) => \(editeurs.count) editors loaded")
        #endif
        self.editeurList.editeurListState = .ready
    }
    
    func httpJsonLoaded(result: Result<[Editeur], HttpRequestError>){
        switch result {
        case let .success(data):
            #if DEBUG
            debugPrint("SearchIntent: httpJsonLoaded -> success -> .loaded(editors)")
            #endif

            editeurList.editeurListState = .loaded(data)

        case let .failure(error):
            editeurList.editeurListState = .loadingError(error)
        }
    }
    
    func editeurLoaded(){
        #if DEBUG
        debugPrint("SearchIntent: editor deleted => save data")
        #endif
        editeurList.editeurListState = .ready
    }

    var editeurFilter : String? = nil

    func loadEditeurs(url : String, editeurFilter: String?){
        self.editeurFilter = editeurFilter
        #if DEBUG
        debugPrint("SearchIntent: .loading(\(url))")
        debugPrint("SearchIntent: asyncLoadEditors")
        #endif
        editeurList.editeurListState = .loading(url)
    }
    
    func loadData() {
        
        var re = [Editeur]()

        
        editeurList.editeurListState = .loading("http://15.236.140.17:8080//api/custom/participants")
        let surl = "http://15.236.140.17:8080//api/custom/participants"
        guard let url = URL(string: surl) else { print("rien"); return }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data,response,error in
            guard let data = data else{return}

            do{
                re = try JSONDecoder().decode([Editeur].self, from: data)
                DispatchQueue.main.async { // met dans la file d'attente du thread principal l'action qui suit
                    self.editeurList.editeurListState = .loaded(re)
                }
                
                }catch{
                    DispatchQueue.main.async { // met dans la file d'attente du thread principal l'action qui suit
                        self.editeurList.editeurListState = .loadingError(error)
                    }
                    print("Error: \(error)")
            }

        }.resume()
    }

}

