//
//  WorkoutListHeaderView.swift
//  DeWeese2
//
//  Created by J. DeWeese on 9/27/23.
//

import SwiftUI

struct WorkoutListHeaderView: View {
    //MARK:  PROPERTIES
    @State private var carouselMode: Bool = false
    @State private var isPresented = false
    var body: some View {
        VStack(spacing: 10) {
            HStack {
                Button {
                    HapticManager.notification(type: .success)
                    isPresented = true
                }
            label: {
                MenuButtonView(size: 1, Color: .primary)
                    .foregroundColor(.primary)
                    .frame(width: 40, height: 40)
                    .contentShape(Rectangle())
            }
                Spacer()
                Text("Daily")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .foregroundStyle(.primary)
                
                Text("Workouts")
                    .fontWeight(.bold)
                    .padding(.leading, 10)
                    .foregroundColor(.orange)
                    .offset(y: 2)
                
                Spacer()
                
                Menu {
                    Button("Toggle Carousel Mode (\(carouselMode ? "On" : "Off"))") {
                        carouselMode.toggle()
                        HapticManager.notification(type: .success)
                    }
                } label: {
                    EllipsisView(size: 3, Color: .primary)
                        .foregroundColor(.primary)
                        .frame(width: 40, height: 40)
                        .contentShape(Rectangle())
                }
            }
            .frame(width: UIScreen.main.bounds.width * 0.95, height: 45)
            .padding(.top, 10)
            .padding(.horizontal)
        }
    }
}

#Preview {
    WorkoutListHeaderView()
}
