//
//  HistoryModel.swift
//  DeWeese2
//
//  Created by J. DeWeese on 9/25/23.
//

import Foundation
import RealmSwift

class History: EmbeddedObject, ObjectKeyIdentifiable {
    @Persisted var date: Date?
    @Persisted var exerciseList = List<String>()
    @Persisted var transcript: String?
    var exercises: [String] { Array(exerciseList) }

    convenience init(date: Date = Date(), exercises: [String], transcript: String? = nil) {
        self.init()
        self.date = date
        exerciseList.append(objectsIn: exercises)
        self.transcript = transcript
    }
}
