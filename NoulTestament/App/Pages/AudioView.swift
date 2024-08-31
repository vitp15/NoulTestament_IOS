//
//  AudioView.swift
//  NoulTestament
//
//  Created by Vadim on 29/08/2024.
//

import SwiftUI
import AVKit

struct AudioView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var width : CGFloat = 0
    @State var maxWidth : CGFloat = 0
    @State var player: AVAudioPlayer?
    @State var isPlaying: Bool = false
    @State var isDragged: Bool = false
    @State private var aviableAudio: Bool = false
    @State var currentTime: TimeInterval = 0.0
    @State var totalTime: TimeInterval = 0.0
    
    let book: Book
    let currChapter: Int
    
    var body: some View {
        VStack {
            // Back button
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(.arrow_back)
                }
                Spacer()
            }
            .padding(EdgeInsets(top: 25, leading: 16, bottom: 0, trailing: 0))
            Spacer()
            
            // Book name and chapter
            VStack {
                Text(self.aviableAudio ? book.name : "Acest capitol nu e disponibil")
                    .font(.roboto, size: 40)
                    .fontWeight(.medium)
                    .minimumScaleFactor(0.75)
                    .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color(.onSurface))
                
                Text(self.aviableAudio ? String(currChapter) : "")
                    .font(.roboto, size: 64)
                    .fontWeight(.medium)
                    .minimumScaleFactor(0.75)
                    .lineLimit(1)
                    .foregroundColor(Color(.onSurface))
                    .padding(.top, 10)
            }
            .padding(.horizontal, 16)
            Spacer()
            
            // Skip second buttons
            HStack {
                Button(action: {
                    
                }) {
                    Image(.replay_5)
                }
                Spacer()
                Button(action: {
                    
                }) {
                    Image(.forward_5)
                }
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 32)
            
            // Buttons play, pause, previous and next
            HStack(alignment: .bottom, spacing: 0, content: {
                Button(action: {
                    
                }) {
                    Image(.previous)
                }
                Spacer()
                Button(action: {
                    if isPlaying {
                        self.pause()
                    } else {
                        self.play()
                    }
                }) {
                    Image(isPlaying ? .pause : .play)
                }
                Spacer()
                Button(action: {
                    
                }) {
                    Image(.next)
                }
            })
            .padding(.horizontal, 16)
            .padding(.bottom, 32)
            
            // Time
            VStack {
                ZStack(alignment: .leading) {
                    Capsule().fill(Color(.tertiaryFixedDim)).frame(height: 7)
                    Capsule().fill(Color(.tertiary)).frame(width: self.width, height: 7)
                }
                .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local)
                            .onChanged({ (value) in
                                self.isDragged = true
                                self.width = value.location.x
                            }).onEnded({ (value) in
                                let percent: Double = Double(value.location.x / self.maxWidth)
                                self.seekAudio(to: self.totalTime * percent)
                                self.isDragged = false
                            }))
                .background(GeometryReader { geometry in
                    Color.clear
                        .onAppear {
                            self.maxWidth = geometry.size.width
                        }
                })
                
                HStack {
                    Text(self.timeString(time: self.currentTime))
                        .font(.roboto, size: 16)
                        .fontWeight(.regular)
                        .foregroundColor(Color(.tertiary))
                    Spacer()
                    Text(self.timeString(time: self.totalTime))
                        .font(.roboto, size: 16)
                        .fontWeight(.regular)
                        .foregroundColor(Color(.tertiary))
                }
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 20)
        }
        .background(ZStack {
            Image(.audio_walpaper)
                .resizable()
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .aspectRatio(contentMode: .fill)
                .scaleEffect(/*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/, anchor: .bottomLeading)
                .edgesIgnoringSafeArea([.leading, .trailing, .bottom])
            
            Color(.above_walpapers)
                .edgesIgnoringSafeArea(.all)
        })
        .gesture(
            DragGesture()
                .onChanged { value in
                    if value.translation.width > 70 {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
        )
        .onAppear(perform: {
            self.aviableAudio = self.setupAudio()
            self.play()
        })
        .onReceive(Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()) { _ in
            self.updateProgress()
        }
        .navigationBarHidden(true)
    }
}

struct AudioView_Previews: PreviewProvider {
    static var previews: some View {
        AudioView(book: Book(order: 1, name: "Matei", chapters: 28), currChapter: 3)
    }
}
