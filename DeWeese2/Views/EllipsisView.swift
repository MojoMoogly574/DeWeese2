//
//  ElipsisView.swift
//  DeWeese2
//
//  Created by J. DeWeese on 9/26/23.
//

import SwiftUI

struct EllipsisView: View {
    var size:  CGFloat
    var Color: Color
    var body: some View {
        VStack{
            RoundedRectangle(cornerRadius: 10.0)
                .frame(width: 35, height: 35)
                .foregroundStyle(.colorGray)
                .overlay (
                    HStack {
                        Image(systemName: "circle.fill")
                            .foregroundColor(Color)
                            .font(.system(size: size))
                        Image(systemName: "circle.fill")
                            .foregroundColor(Color)
                            .font(.system(size: size))
                            .padding(.leading, -4)
                        Image(systemName: "circle.fill")
                            .foregroundColor(Color)
                            .font(.system(size: size))
                            .padding(.leading, -4)
                    }
                        
                )
                .foregroundColor(.blue)
            
                .fontWeight(.bold)
                .font(.system(size: 30))
                .rotationEffect(.degrees(90))
                .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
        }
    }
}
#Preview {
    EllipsisView(size: 3, Color: .primary)
}

    
     
    
