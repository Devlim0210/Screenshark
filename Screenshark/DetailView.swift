//
//  DetailView.swift
//  Screenshark
//
//  Created by Ink.limited Ratsimaharison on 07/11/2024.
//

import SwiftUI

struct DetailView: View {
    var film:Film
    
    var body: some View{
        ScrollView { //Permet le défilement pour les textes longs
            VStack {
                Image(film.affiche)
                    .resizable()
                    .scaledToFit()
                    .frame(height:300)
                    .cornerRadius(10)
                    .padding()
                
                //Titre du film
                Text(film.titre)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.horizontal)
                
                //Note du film (exprimée en étoiles)
                HStack {
                    ForEach(0..<min(5, Int(film.note.rounded())), id: \.self) {
                        _ in Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                    }
                    Text(String(format: "%.1f", film.note))
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
                
                Text(film.synopsis)
                    .padding(.horizontal)
                    .padding(.bottom)
            }
            .navigationTitle(film.titre)
        }
    }
    
    struct DetailView_Previews: PreviewProvider {
        static var previews: some View {
            // Exemple de film fictif pour la prévisualisation
            let exampleFilm = Film(
                titre: "Inception",
                affiche: "inception",
                synopsis: "A mind-bending thriller.",
                genre: "Sci-Fi",
                note: 8.8,
                isFavorite: false
            )
            
            //exemple de film pour prévisualiser la vue
            DetailView(film: exampleFilm)
        }
    }
}
