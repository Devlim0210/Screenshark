//
//  ContentView.swift
//  Screenshark
//
//  Created by Ink.limited Ratsimaharison on 07/11/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var searchText = ""
    @State private var movies: [Movie] = []
    @State private var showFavoritesOnly = false
    
    let movieService = MovieService()
    
    var filteredFilms: [Movie] {
        let filmsToShow = showFavoritesOnly ? movies.filter { $0.isFavorite } : movies
        if searchText.isEmpty {
            return filmsToShow
        } else {
            return filmsToShow.filter { $0.title.lowercased().contains(searchText.lowercased()) }
        }
    }
    
    var body: some View {
        NavigationView { // Début NavigationView
            VStack (alignment:.leading){ // Début VStack principal
                // Titre et barre de recherche
                Text("Welcome to Screenshark")
                    .font(.largeTitle)
                    .foregroundColor(.primary)
                    .padding(.horizontal)
                
                // Champ de recherche
                TextField("Search movies", text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                
                // Toggle pour afficher uniquement les favoris
                Toggle(isOn: $showFavoritesOnly) {
                    Text("Show Favorites Only")
                        .foregroundColor(.primary)
                }
                .padding(.horizontal)
                
                Spacer(minLength: 0)
                
                // Liste des films filtrée
                List {
                    ForEach(filteredFilms) { film in // Début ForEach pour parcourir chaque film dans la liste filtée
                        
                        NavigationLink(destination: DetailView(movie: film)) { // Lien vers la vue de détail
                        HStack { // Début HStack pour chaque film
                            // Image du film avec chargement asynchrone
                            if let posterPath = film.posterPath {
                                AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")) { image in
                                    image.resizable()
                                } placeholder: {
                                    Color.gray
                                }
                                .frame(width: 50, height: 75)
                                .cornerRadius(5)
                            }
                            
                            // Détails du film (titre et genre)
                            VStack(alignment: .leading) { // Début VStack pour les détails du film
                                Text(film.title)
                                    .font(.headline)
                                    .foregroundColor(.primary)  //texte adaptif
                                Text(film.releaseDate ?? "Unknown")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)  //Texte secondaire adaptif
                            } // Fin VStack pour les détails du film
                            
                            Spacer()
                            
                            // Bouton de favori
                            Button(action: {
                                toggleFavorite(for: film)
                            }) {
                                Image(systemName: film.isFavorite ? "heart.fill" : "heart")
                                    .foregroundColor(film.isFavorite ? .red : .gray)
                            }
                            .buttonStyle(BorderlessButtonStyle())  //assure que le bouton ne se capte que son propre clic
                        } // Fin HStack pour chaque film
                    }// Fin Navigationlink
                        } // Fin ForEach
                    } // Fin List
                    
                    .navigationTitle("Movies") //Titre de la vue Navigation
                    .background(Color("AppBackground")) // Utilisation d'une couleur personnalisée
                    .ignoresSafeArea()
             
               
                .onAppear {
                    // Récupère les films depuis l'API TMDb dès que la vue apparaît
                    movieService.fetchPopularMovies { movies in
                        if let movies = movies {
                            self.movies = movies
                        }
                    }
                }
            } // Fin VStack principal
            } // Fin NavigationView
            
        }
    
    // Fonction pour basculer le favori
    func toggleFavorite(for film: Movie) {
        if let index = movies.firstIndex(where: { $0.id == film.id }) {
            movies[index].isFavorite.toggle()
        }
    }
}

// Aperçu
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.light) // Aperçu en mode clair
        ContentView()
            .preferredColorScheme(.dark) // Aperçu en mode sombre
    }
}
