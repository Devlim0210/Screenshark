//
//  Film.swift
//  Screenshark
//
//  Created by Ink.limited Ratsimaharison on 07/11/2024.
//

import Foundation

struct Film: Identifiable {
    let id = UUID()
    let titre: String
    let affiche: String
    let synopsis: String
    let genre: String
    let note: Double
    var isFavorite: Bool = false //proprieté favorite par défaut
}

