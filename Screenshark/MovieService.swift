//
//  MovieService.swift
//  Screenshark
//
//  Created by Ink.limited Ratsimaharison on 12/11/2024.
//

import Foundation

//service pour gérer les requêtes vers l'API tmDb
class MovieService{
    // Clé API pour accéder à TMDb, stockée dans la configuration pour la sécurité
    private let apiKey = Configuration.apiKey
    // URL de base de l'API TMDb
    private let baseURL = "https://api.themoviedb.org/3"
    
    // Fonction pour récupérer les films populaires
      // Utilise une fermeture (closure) pour renvoyer les résultats de manière asynchrone
    func fetchPopularMovies(completion: @escaping ([Movie]?) -> Void){
        // Construction de l'URL avec la clé API et les paramètres de langue et de page
               let urlString = "\(baseURL)/movie/popular?api_key=\(apiKey)&language=en-US&page=1"
               
               // Vérifie que l'URL est valide
               guard let url = URL(string: urlString) else {
                   // Si l'URL est invalide, appelle la closure avec nil pour indiquer l'échec
                   completion(nil)
                   return
               }

               // Crée une tâche de session pour récupérer les données depuis l'URL
               URLSession.shared.dataTask(with: url) { (data, response, error) in
                   // Gestion des erreurs de requête
                   if let error = error {
                       print("Erreur lors de la récupération des films : \(error)")
                       // Appelle la closure avec nil pour indiquer l'échec
                       completion(nil)
                       return
                   }

                   // Vérifie que les données existent, sinon appelle la closure avec nil
                   guard let data = data else {
                       completion(nil)
                       return
                   }

                   do {
                       // Décode les données JSON reçues en un objet MovieResponse
                       let decoder = JSONDecoder()
                       let movieResponse = try decoder.decode(MovieResponse.self, from: data)
                       
                       // Appelle la closure avec les résultats décodés
                       completion(movieResponse.results)
                   } catch {
                       // Gestion des erreurs de décodage JSON
                       print("Erreur lors du décodage des films : \(error)")
                       // Appelle la closure avec nil en cas d'échec de décodage
                       completion(nil)
                   }
               }.resume() // Lance la tâche de récupération
           }
       }

       // Structure pour décoder la réponse de l'API, qui contient une liste de films
       struct MovieResponse: Codable {
           let results: [Movie] // Tableau de films renvoyé par l'API
       }
