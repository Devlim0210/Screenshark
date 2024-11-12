//
//  ContentView.swift
//  Screenshark
//
//  Created by Ink.limited Ratsimaharison on 07/11/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var searchText = ""
    @State private var filmsFictifs = [
        Film(titre: "Inception", affiche: "inception", synopsis: "A mind-bending thriller.", genre: "Sci-Fi", note: 8.8),
        Film(titre: "The Matrix", affiche: "matrix", synopsis: "A hacker discovers reality is a simulation.", genre: "Sci-Fi", note: 8.7),
        Film(titre: "Interstellar", affiche: "interstellar", synopsis: "Exploring space to save humanity.", genre: "Sci-Fi", note: 8.6)
    ]

        // Fonction pour filtrer la liste des films
        var filteredFilms: [Film] {
            if searchText.isEmpty {
                return filmsFictifs
            } else {
                return filmsFictifs.filter { $0.titre.lowercased().contains(searchText.lowercased()) }
            }
        }

    var body: some View {
        NavigationView {
            VStack {
                //Titre et Barre de recherche
                Text("Welcome to Screenshark")
                    .font(.largeTitle)
                    .padding()
                
                // Champ de recherche
                               TextField("Search movies", text: $searchText)
                                   .textFieldStyle(RoundedBorderTextFieldStyle())
                                   .padding()
                
                //Liste des films filtrée
                List(filteredFilms.indices, id: \.self) { index in
                                   let film = filteredFilms[index]
                    HStack {
                    //placement le Navigationlink autour du contenu principal
                        HStack {
                            NavigationLink(destination: DetailView(film: film)) {
                                Image(film.affiche)
                                    .resizable()
                                    .frame(width: 50, height:75)
                                    .cornerRadius(5)
                                
                                VStack(alignment : .leading){
                                    Text(film.titre)
                                        .font(.headline)
                                    Text(film.genre)
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                            Spacer()
                            //Bouton de favori
                            Button(action: {
                                toggleFavorite(for: index)
                            }) {
                                Image(systemName: film.isFavorite ? "heart.fill" : "heart")
                                    .foregroundColor(film.isFavorite ? .red : .gray)
                            }
                            .buttonStyle(BorderlessButtonStyle()) // Assure que le bouton ne capte que son propre clic
                        }
                    }
                    .navigationTitle("Movies")
                }
            }
        }
        
        func toggleFavorite(for index: Int) {
            filmsFictifs[index].isFavorite.toggle()
        }
    }

    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
