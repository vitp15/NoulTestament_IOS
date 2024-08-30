//
//  AudioView.swift
//  NoulTestament
//
//  Created by Vadim on 29/08/2024.
//

import SwiftUI

struct AudioView: View {
    @Environment(\.presentationMode) var presentationMode
    let book: Book
    let currChapter: Int
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(.arrow_back)
                }
                .padding(EdgeInsets(top: 25, leading: 16, bottom: 0, trailing: 0))
                Spacer()
            }
            
            // Chapter title and number
            Spacer()
            VStack {
                Text(book.name)
                    .font(.roboto, size: 40)
                    .fontWeight(.medium)
                    .foregroundColor(Color(.onSurface))
                
                Text(String(currChapter))
                    .font(.roboto, size: 64)
                    .fontWeight(.medium)
                    .foregroundColor(Color(.onSurface))
                    .padding(.top, 10)
            }
            Spacer()
            
            // Playback controls
            HStack {
                // Rewind 5 seconds
                Button(action: {
                    // Handle rewind action
                }) {
                    Image(systemName: "gobackward.5")
                        .font(.system(size: 40))
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                // Play/Pause button
                Button(action: {
                    // Handle play/pause action
                }) {
                    Image(systemName: "play.circle.fill")
                        .font(.system(size: 80))
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                // Forward 5 seconds
                Button(action: {
                    // Handle forward action
                }) {
                    Image(systemName: "goforward.5")
                        .font(.system(size: 40))
                        .foregroundColor(.secondary)
                }
            }
            .padding(.horizontal, 50)
            
            // Progress bar with time
            VStack {
                Slider(value: .constant(0.2), in: 0...1)
                    .accentColor(.secondary)
                
                HStack {
                    Text("1:23")
                        .font(.custom("Roboto-Regular", size: 14))
                        .foregroundColor(.secondary)
                    Spacer()
                    Text("6:44")
                        .font(.custom("Roboto-Regular", size: 14))
                        .foregroundColor(.secondary)
                }
            }
            .padding(.horizontal)
        }
        .navigationBarHidden(true)
    }
}

struct AudioView_Previews: PreviewProvider {
    static var previews: some View {
        AudioView(book: Book(order: 1, name: "Matei", chapters: 28), currChapter: 3)
    }
}
