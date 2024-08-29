//
//  BookItemView.swift
//  NoulTestament
//
//  Created by Vadim on 29/08/2024.
//

import SwiftUI

struct BookItemView: View {
    let name: String
    
    var body: some View {
        VStack {
            HStack {
                Image(.book)
                
                Text(name)
                    .font(.roboto_medium, size: 24)
                    .foregroundColor(Color(.onSurface))
                    .background(Color.clear)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.trailing, 24)
                    .minimumScaleFactor(0.75)
                    .lineLimit(1)
            }
            Rectangle()
                .frame(height: 1)
                .foregroundColor(Color(.outline))
        }
        .frame(height: 52, alignment: .bottom)
        .background(Color.clear)
    }
}

struct BookItemView_Previews: PreviewProvider {
    static var previews: some View {
        BookItemView(name: "Matei")
    }
}
