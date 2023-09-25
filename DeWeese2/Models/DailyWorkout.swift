//
//  DailyWorkout.swift
//  DeWeese2
//
//  Created by J. DeWeese on 9/25/23.
//

import RealmSwift
import SwiftUI

class DailyWorkout: Object, ObjectKeyIdentifiable {
    @Persisted var workoutTitle = ""
    @Persisted var workoutDescription = ""
    @Persisted var workoutType = ""
    @Persisted var exerciseList = RealmSwift.List<String>()
    @Persisted var colorComponents: Components?
    @Persisted var historyList = RealmSwift.List<History>()
    
    var color: Color { Color(colorComponents ?? Components()) }
    var exercises: [String] { Array(exerciseList) }
    var history: [History] { Array(historyList) }
    
    convenience init(workoutTitle: String,workoutDescription: String, WorkoutType: String, exercises: [String],color: Color, history: [History] = []) {
        self.init()
        self.workoutTitle = workoutTitle
        self.workoutDescription = workoutDescription
        self.workoutType = workoutType
        exerciseList.append(objectsIn: exercises)
        self.colorComponents = color.components
        for entry in history {
            self.historyList.insert(entry, at: 0)
        }
    }
}

extension DailyWorkout {
    static var data: [DailyWorkout] {
        [
            DailyWorkout(workoutTitle: "Murph", workoutDescription: "Complete 1 round for time.", WorkoutType: "HIIT", exercises: ["100 Pull-Ups", "200 Push-ups", "300 Sit Ups", "Run 1 mile", "400 Boot Slappers"], color: .HIIT)
        ]
    }
}

extension DailyWorkout {
    struct Data {
        var title: String = ""
        var exercises: [String] = []
        var color: Color = .random
    }

    var data: Data {
        return Data(title: workoutTitle, exercises: exercises, color: color)
    }
    
    func update(from data: Data) {
        workoutTitle = data.title
        for exercise in data.exercises {
            if !exercises.contains(exercise) {
                self.exerciseList.append(exercise)
            }
        }
        colorComponents = data.color.components
    }
}

