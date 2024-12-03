//
//  DetailView.swift
//  Screenshark
//
//  Created by Ink.limited Ratsimaharison on 07/11/2024.
//

import SwiftUI

struct DetailView: View {
    var movie:Movie  //change le type de Film à Movie
    
    var body: some View{
        ScrollView { //Permet le défilement pour les textes longs
            VStack(alignment: .leading) {
                if let posterPath = movie.posterPath {
                    AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")) {image in
                        image.resizable()
                    }
                    placeholder:{
                        Color.gray
                    }
                    
                    .scaledToFit()
                    .frame(height:300)
                    .cornerRadius(10)
                    .padding()
                    
                    //Titre du film
                    Text(movie.title) //Utilise movie.title au lieu de film.title
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.horizontal)
                    
                    //Note du film (exprimée en étoiles)
                    HStack {
                        ForEach(0..<min(5, Int(movie.voteAverage.rounded())), id: \.self) {
                            _ in Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                        }
                        Text(String(format: "%.1f", movie.voteAverage))
                            .foregroundColor(.gray)
                            .padding(.horizontal)
                    }
                    .padding(.horizontal)
                    
                    //Synopsis du film
                    Text("Synopsis")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .padding(.top)
                        .padding(.horizontal)
                    
                    Text(movie.overview)
                        .padding(.horizontal)
                        .padding(.bottom)
                }}
                    .frame(maxWidth: .infinity)  // Permet au contenu de s'étendre horizontalement
                    .navigationTitle(movie.title) // Titre de navigation
                
            }
        }
    }
    
    struct DetailView_Previews: PreviewProvider {
        static var previews: some View {
            // Exemple de film fictif pour la prévisualisation
            DetailView(movie: Movie(
                id: 1,
                title: "Inception",
                overview:"A mind-bending thriller.",
                posterPath: "/inception.jpg",
                releaseDate: "2010-07-",
                voteAverage: 8.8
                
                
            ))
            
       
        }
    }

