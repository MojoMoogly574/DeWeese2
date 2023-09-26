//
//  Theme.swift
//  DeWeese2
//
//  Created by J. DeWeese on 9/25/23.
//

import SwiftUI

enum Theme: String, CaseIterable, Identifiable, Codable {
    case BackPack
    case Cardio
    case Golf
    case Grapple
    case HIIT
    case Hockey
    case PickleBall
    case Power
    case Recover
    case Run
    case Sport
    case Strength
    case Stretch
    case Walk
    case Yoga
    
    var accentColor: Color {
        // returns .black or .white depending on the color of self
        switch self {
        case .BackPack, .Cardio, .Grapple,.HIIT, .Sport, .Recover,.Golf, .Hockey, .Power, .Run, .Strength, .Stretch, .Walk, .Yoga: return .white
        case .PickleBall: return .black
        
        }
    }
    
    var mainColor: Color {
        Color(rawValue)
    }
    
    var name: String {
        rawValue.capitalized
    }
    
    var id: String {
        name
    }
}
