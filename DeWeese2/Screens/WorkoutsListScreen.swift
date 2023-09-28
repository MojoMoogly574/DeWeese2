//
//  WorkoutsListScreen.swift
//  DeWeese2
//
//  Created by J. DeWeese on 9/26/23.
//

import SwiftUI
import RealmSwift




struct WorkoutsListScreen: View {
    @State private var carouselMode: Bool = false
    /// For Matched Geometry Effect
    @Namespace private var animation
    @State var width = UIScreen.main.bounds.width
    /// Detail View Properties
    @State private var showDetailView: Bool = false
    @State private var selectedWorkout: DailyWorkout?
    @State private var animateCurrentWorkout: Bool = false
    @ObservedResults(DailyWorkout.self) var workouts
    @State private var isPresented = false
    @State private var newWorkoutData = DailyWorkout.Data()
    @State private var currentWorkout = DailyWorkout()
    var body: some View {
        VStack{
            //MARK:  WORKOUT LIST HEADER VIEW
            WorkoutListHeaderView()
            
            //MARK:  SCROLL VIEW
            GeometryReader {
                let size = $0.size
                
                ScrollView(.vertical, showsIndicators: false) {
                    /// Books Card View
                    VStack(spacing: 35) {
                        ForEach(workouts) { workout in
                            WorkoutCardView(workout: workout)
                            /// Opening Detail View, When Ever Card is Tapped
                                .onTapGesture {
                                    withAnimation(.easeInOut(duration: 0.2)) {
                                        animateCurrentWorkout = true
                                        selectedWorkout = workout
                                    }
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                                        withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)) {
                                            showDetailView = true
                                        }
                                    }
                                }
                        }
                    }
                    .padding(.horizontal, 15)
                    .padding(.vertical, 20)
                    .padding(.bottom, bottomPadding(size))
                    .background {
                        ScrollViewDetector(carouselMode: $carouselMode, totalCardCount: workouts.count)
                    }
                }
                /// Since we need offset from here and not from global View
                .coordinateSpace(name: "SCROLLVIEW")
            }//geometry reader
            .padding(.top, 15)
        .overlay {
            if let selectedWorkout, showDetailView {
                WorkoutDetailView()
                /// For More Fluent Animation Transition
                    .transition(.asymmetric(insertion: .identity, removal: .offset(y: 5)))
            }
        }
        .onChange(of: showDetailView) { newValue in
            if !newValue {
                /// Resetting Book Animation
                withAnimation(.easeInOut(duration: 0.15).delay(0.4)) {
                    animateCurrentWorkout = false
                }
            }
        }
        Button(action: {
            isPresented = true
            HapticManager.notification(type: .success)
        }, label: {
            Image(systemName: "plus")
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .padding(13)
                .background(Color.colorOrange,in: Circle())
        })
}
    .sheet(isPresented: $isPresented) {
        NavigationView {
            WorkoutEditScreen(workoutData: $newWorkoutData)
                .navigationBarItems(leading: Button("Dismiss") {
                    isPresented = false
                }, trailing: Button("Add") {
                    let newWorkout = DailyWorkout(workoutTitle: newWorkoutData.workoutTitle, workoutDescription: newWorkoutData.workoutDescription, WorkoutType: newWorkoutData.workoutType, exercises: newWorkoutData.exercises, color: newWorkoutData.color)
                    $workouts.append(newWorkout)
                    isPresented = false
                })
        }
        }
    }
}
        /// Bottom Padding for last card to move up to the top
        func bottomPadding(_ size: CGSize = .zero) -> CGFloat {
            let cardHeight: CGFloat = 220
            let scrollViewHeight: CGFloat = size.height
            
            return scrollViewHeight - cardHeight - 40
        }
        
    

