//
//  ThemePicker.swift
//  DeWeese2
//
//  Created by J. DeWeese on 9/25/23.
//



import SwiftUI

struct ThemePicker: View {
    // communicates changes to theme within the theme picker back up to parent view
    @Binding var selection: Theme
    
    var body: some View {
        Picker("Theme", selection: $selection) {
            ForEach(Theme.allCases) { theme in
                ThemeView(theme: theme)
                    // tagging subview to differentiate in picker
                    .tag(theme)
            }
        }
        .pickerStyle(.wheel)
    }
}


#Preview {
    ThemePicker(selection: .constant(.Cardio))
}
