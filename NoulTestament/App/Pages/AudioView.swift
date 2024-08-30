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
        ZStack {
            // Background color
            Color(UIColor(named: "CustomBackgroundColor") ?? UIColor(red: 1, green: 1, blue: 0.9647, alpha: 1))
                .ignoresSafeArea()
            
            // Background image (use your image here)
            Image("backgroundImage")
                .resizable()
                .scaledToFit()
                .opacity(0.1)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                // Navigation bar with back button
                HStack {
                    Button(action: {
                        // Handle back action
                    }) {
                        Image(systemName: "arrow.left")
                            .foregroundColor(.black)
                            .font(.title)
                    }
                    Spacer()
                }
                .padding()
                
                // Chapter title and number
                Spacer()
                VStack {
                    Text("Matei")
                        .font(.custom("Roboto-Bold", size: 36))
                        .foregroundColor(.black)
                    
                    Text("4")
                        .font(.custom("Roboto-Bold", size: 64))
                        .foregroundColor(.black)
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
        }
    }
}

struct AudioView_Previews: PreviewProvider {
    static var previews: some View {
        AudioView(book: Book(order: 1, name: "Matei", chapters: 28), currChapter: 3)
    }
}
