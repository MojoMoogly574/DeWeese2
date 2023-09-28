//
//  MenuButtonView.swift
//  DeWeese2
//
//  Created by J. DeWeese on 9/26/23.
//

import SwiftUI

struct MenuButtonView: View {
    var size:  CGFloat
    var Color: Color
    var body: some View {
        VStack{
            RoundedRectangle(cornerRadius: 10.0)
                .frame(width: 35, height: 35)
                .foregroundStyle(.colorGray)
                .overlay (
                    HStack {
                        Image(systemName: "line.3.horizontal")
                            .fontWeight(.light)
                            .foregroundColor(Color)
                           .font(.system(size: 25))
                        
                    })
                .foregroundColor(.primary)
                .fontWeight(.none)
                .padding(.horizontal)
                .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
        }
    }
}
#Preview {
    MenuButtonView(size: 3, Color: .primary)
}

    
     
    

