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
        HStack {
            Image(.book)
            
            Text(name)
                .font(.roboto_medium, size: 24)
                .foregroundColor(Color(.onSurface))
                .background(Color.clear)
                .frame(maxWidth: .infinity, alignment: .center)
        }
        .frame(height: 52)
        .background(Color.clear)
    }
}

struct BookItemView_Previews: PreviewProvider {
    static var previews: some View {
        BookItemView(name: "Matei")
    }
}
