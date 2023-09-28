//
//  WorkoutCardView.swift
//  DeWeese2
//
//  Created by J. DeWeese on 9/26/23.
//

import SwiftUI
import RealmSwift



struct WorkoutCardView: View {
    //MARK:  PROPERTIES
    @ObservedRealmObject var workout: DailyWorkout
    @State var width = UIScreen.main.bounds.width
    @State private var data = DailyWorkout.Data()
    /// For Matched Geometry Effect
    @Namespace private var animation
    /// Detail View Properties
    @State private var showDetailView: Bool = false
    @State private var selectedWorkout: DailyWorkout?
    @State private var animateCurrentWorkout: Bool = false
    @State private var isPresented = false

    var body: some View {

            HStack(spacing: -25) {
                /// Book Detail Card
                /// Placing this card above the cover image
                VStack{
                    //MARK:  WORKOUT NAME
                    SwiftUI.Section(header: Text("Workout Name").font(.system(size: 14)).foregroundColor(.primary)) {
                        Text(workout.workoutTitle)
                            .padding()
                            .background(Color(UIColor.tertiarySystemFill))
                            .lineLimit(1)
                            .cornerRadius(10)
                            .foregroundStyle(workout.color)
                            .padding(.horizontal)
                    } .fontWeight(.bold)
                    //MARK:  WORKOUT DESCRIPTION
                    SwiftUI.Section(header: Text("Workout Description").font(.system(size: 14)).foregroundColor(.primary)) {
                        Text(workout.workoutDescription)
                            .frame(width: width * 0.85, height: 75)
                            .multilineTextAlignment(.leading)
                            .lineLimit(5)
                            .padding(2)
                            .background(Color(UIColor.tertiarySystemFill))
                            .cornerRadius(10)
                            .font(.system(size: 14))
                            .foregroundStyle(workout.color)
                    }.foregroundStyle(workout.color)
                        .fontWeight(.bold)
                        .padding(.top,10)
                    SwiftUI.Section(header: Text("Workout Type").font(.system(size: 14)).foregroundColor(.primary)) {
                        Text(workout.workoutType)
                            .padding()
                            .background(Color(UIColor.tertiarySystemFill))
                            .lineLimit(1)
                            .cornerRadius(10)
                            .foregroundStyle(workout.color)
                            .padding(.horizontal)
                    }
                    SwiftUI.Section(header: Text("Exercises").font(.system(size: 14)).foregroundColor(.primary)) {
                        ForEach(workout.exercises, id: \.self) { exercise in
                            Text(exercise)
                        }
                    }
                    //                /// Rating View
                    //                RatingView(rating: book.rating)
                    //                    .padding(.top, 10)
                    
                    Spacer(minLength: 10)
                    
                    HStack(spacing: 4) {
                        
                        Text("Views")
                            .font(.caption)
                            .foregroundColor(.gray)
                        
                        Spacer(minLength: 0)
                        
                        Image(systemName: "chevron.right")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    .padding(20)
                    .background {
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .fill(.white)
                        /// Applying Shadow
                            .shadow(color: .black.opacity(0.08), radius: 8, x: 5, y: 5)
                            .shadow(color: .black.opacity(0.08), radius: 8, x: -5, y: -5)
                    }
                    .zIndex(1)
                    /// Moving the book, it it's tapped
                    .offset(x: animateCurrentWorkout && selectedWorkout?.id == workout.id ? -20 : 0)
                    
                    /// Book Cover Image
                    ZStack {
                        if !(showDetailView && selectedWorkout?.id == workout.id) {
                            Image(systemName:"gear")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                            /// Matched Geometry ID
                                .matchedGeometryEffect(id: workout.id, in: animation)
                            /// Applying Shadow
                                .shadow(color: .black.opacity(0.1), radius: 5, x: 5, y: 5)
                                .shadow(color: .black.opacity(0.1), radius: 5, x: -5, y: -5)
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
//                  .rotation3DEffect(.init(degrees: convertOffsetToRotation(rect)), axis: (x: 1, y: 0, z: 0), anchor: .bottom, anchorZ: 1, perspective: 0.8)
                }
                .frame(height: 220)
            }
        
            /// Converting MinY to Rotation
            func convertOffsetToRotation(_ rect: CGRect) -> CGFloat {
                let cardHeight = rect.height + 20
                let minY = rect.minY - 20
                let progress = minY < 0 ? (minY / cardHeight) : 0
                let constrainedProgress = min(-progress, 1.0)
                return constrainedProgress * 90
            }
        }
    

#Preview {
    ContentView()
}
