//
//  searchBar.swift
//  festival-jeu
//
//  Created by ayoub moujane on 29/03/2021.
//

import Foundation
import SwiftUI

struct SearchBar : View {
    @Binding var text: String
    @State private var isEditing = false
    var body: some View {
        HStack{
            TextField("Search here...", text: $text)
                .padding(15)
                .padding(.horizontal,25)
                .background(Color(.systemGray6))
                .foregroundColor(.black)
                .cornerRadius(8)
                .overlay(
                    HStack{
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading,15)
                        
                        if isEditing{
                            Button(action : {
                                self.text = ""
                            }, label : {
                                Image(systemName: "multiply.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing,8)
                            })
                        }
                        
                        
                    }).onTapGesture {
                        self.isEditing = true
                    }
        }
    }
}
