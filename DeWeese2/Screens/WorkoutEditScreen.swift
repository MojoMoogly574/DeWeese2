//
//  WorkoutEditScreen.swift
//  DeWeese2
//
//  Created by J. DeWeese on 9/25/23.
//

import SwiftUI

struct WorkoutEditScreen: View {
        //MARK:  PROPERTIES
    @Binding var workoutData: DailyWorkout.Data
    @Environment(\.presentationMode) var presentationMode
    @State private var newExercise = ""
    @State var width = UIScreen.main.bounds.width
    //MARK:  WORKOUT TYPES 
    let types = ["Strength", "Power", "Cardio", "HIIT", "Recover", "Yoga","Sport", "Run", "Walk", "Grappling", "Boxing", "MMA", "Golf", "Stretch", "Swim"]
     
    var body: some View {
        NavigationView {
            ZStack {
                Color.clear.ignoresSafeArea()
                List {
                    VStack{
                        //MARK:  WORKOUT NAME
                        Section(header: Text("Workout Name").font(.system(size: 14)).foregroundColor(.primary)) {
                            TextField("Enter Workout Name...", text: $workoutData.workoutTitle)
                                .padding()
                                .background(Color(UIColor.tertiarySystemFill))
                                .lineLimit(1)
                                .cornerRadius(10)
                                .foregroundStyle(workoutData.color)
                                .padding(.horizontal)
                        } .fontWeight(.bold)
                        //MARK:  WORKOUT DESCRIPTION
                        Section(header: Text("Workout Description").font(.system(size: 14)).foregroundColor(.primary)) {
                            TextEditor(text: $workoutData.workoutDescription)
                                .frame(width: width * 0.85, height: 75)
                                .multilineTextAlignment(.leading)
                                .lineLimit(5)
                                .padding(2)
                                .background(Color(UIColor.tertiarySystemFill))
                                .cornerRadius(10)
                                .font(.system(size: 14))
                                .foregroundStyle(workoutData.color)
                        }.foregroundStyle(workoutData.color)
                            .fontWeight(.bold)
                            .padding(.top,10)
                        
                        //MARK:  WORKOUT TYPE PICKER
                        Section(header: Text("Select Workout Type").font(.system(size: 14)).fontWeight(.bold).foregroundStyle(.primary)) {
                            Picker("Select Workout type:", selection: $workoutData.color) {
                                ForEach(Theme.allCases) { theme in
                                    ThemeView(theme: theme)
                                    // tagging subview to differentiate in picker
                                        .tag(theme)
                                }
                            }
                            .pickerStyle(.wheel)
                        }.padding(.horizontal, 1)
                        
                        //MARK:  EXERCISE LIST
                        Section(header: Text("Exercises").font(.system(size: 19)).fontWeight(.bold).foregroundStyle(.primary)) {
                            ForEach(workoutData.exercises, id: \.self) { exercise in
                                Text(exercise)
                            }
                            .onDelete { indices in
                                workoutData.exercises.remove(atOffsets: indices)
                            } .foregroundStyle(workoutData.color)
                        }
                        HStack {
                            TextField("New Exercise", text: $newExercise)
                            Button(action: {
                                withAnimation {
                                    workoutData.exercises.append(newExercise)
                                    newExercise = ""
                                }
                            }) {
                                Image(systemName: "plus.circle.fill")
                                    .accessibilityLabel(Text("Add exercise"))
                            }
                            .disabled(newExercise.isEmpty)
                        }
                            .padding(.horizontal)
                            .padding(7)
                        
                        Spacer()
                        //MARK:  SAVE BUTTON
                        Button {
                            WorkoutScreen()
                            HapticManager.notification(type: .success)
                        } label: {
                            Text("Begin Workout")
                                .font(.title3)
                                .fontWeight(.bold)
                                .padding(.horizontal, 45)
                                .padding(.vertical, 10)
                                .background {
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(workoutData.color.gradient)
                                }
                                .foregroundColor(.white)
                        }
                    }
            }
                .listStyle(InsetGroupedListStyle())
                .padding(.horizontal, 1)
                    .cornerRadius(10, antialiased: true)
                .listRowBackground(workoutData.color)
            }
        }
    }
    }
struct WorkoutEditScreen_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutEditScreen(workoutData: .constant(DailyWorkout.data[0].data))
    }
}
