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
    @Environment(\.scenePhase) private var scenePhase
    @State var width : CGFloat = 0
    @State var maxWidth : CGFloat = 0
    @State var player: AVAudioPlayer?
    @State var isPlaying: Bool = false
    @State var isDragged: Bool = false
    @State var aviableAudio: Bool = false
    @State var currentTime: TimeInterval = 0.0
    @State var totalTime: TimeInterval = 0.0
    @State var delegate: AVdelegate = AVdelegate()
    @State var backClicked: Bool = false
    
    @State var book: Book
    @State var currChapter: Int
    
    let  onPause: Bool
    
    init(book: Book, currChapter: Int, onPause: Bool) {
        _book = State(initialValue: book)
        _currChapter = State(initialValue: currChapter)
        self.onPause = onPause
    }
    
    var body: some View {
        VStack {
            // Back button
            HStack {
                Button(action: {
                    back()
                }) {
                    Image(.arrow_back)
                }
                Spacer()
            }
            .padding(EdgeInsets(top: 25, leading: 16, bottom: 0, trailing: 0))
            Spacer()
            
            ZStack {
                // Background with double tap
                HStack {
                    Rectangle()
                        .foregroundColor(Color.clear)
                        .contentShape(Rectangle())
                        .onTapGesture(count: 2, perform: {
                            replay(time: 5)
                        })
                    
                    Rectangle()
                        .foregroundColor(Color.clear)
                        .contentShape(Rectangle())
                        .onTapGesture(count: 2, perform: {
                            forward(time: 5)
                        })
                }
                
                // Book name and chapter
                VStack {
                    Text(aviableAudio ? book.name : "Acest capitol momentan nu e disponibil")
                        .font(.roboto, size: 40)
                        .fontWeight(.medium)
                        .minimumScaleFactor(0.75)
                        .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color(.onSurface))
                    
                    Text(aviableAudio ? String(currChapter) : "")
                        .font(.roboto, size: 64)
                        .fontWeight(.medium)
                        .minimumScaleFactor(0.75)
                        .lineLimit(1)
                        .foregroundColor(Color(.onSurface))
                        .padding(.top, 10)
                }
                .padding(.horizontal, 16)
            }
            Spacer()
            
            // Skip second buttons
            HStack {
                Button(action: {
                    replay(time: 5)
                }) {
                    Image(.replay_5)
                }
                Spacer()
                Button(action: {
                    forward(time: 5)
                }) {
                    Image(.forward_5)
                }
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 32)
            
            // Buttons play, pause, previous and next
            HStack(alignment: .bottom, spacing: 0, content: {
                Button(action: {
                    previous()
                }) {
                    Image(.previous)
                }
                Spacer()
                Button(action: {
                    if let player = self.player {
                        if player.isPlaying {
                            pause()
                        } else {
                            play()
                        }
                    }
                }) {
                    if let player = self.player {
                        Image(player.isPlaying ? .pause : .play)
                    } else {
                        Image(.play)
                    }
                }
                Spacer()
                Button(action: {
                    next()
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
                    Capsule().fill(Color(.tertiary)).frame(width: width, height: 7)
                }
                .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local)
                            .onChanged({ (value) in
                                isDragged = true
                                width = value.location.x
                            }).onEnded({ (value) in
                                let percent: Double = Double(value.location.x / maxWidth)
                                seekAudio(to: totalTime * percent)
                                isDragged = false
                            }))
                .background(GeometryReader { geometry in
                    Color.clear
                        .onAppear {
                            maxWidth = geometry.size.width
                        }
                })
                
                HStack {
                    Text(timeString(time: currentTime))
                        .font(.roboto, size: 16)
                        .fontWeight(.regular)
                        .foregroundColor(Color(.tertiary))
                    Spacer()
                    Text(timeString(time: totalTime))
                        .font(.roboto, size: 16)
                        .fontWeight(.regular)
                        .foregroundColor(Color(.tertiary))
                }
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 20)
        }
        .frame(maxWidth: 700)
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
                        back()
                    }
                }
        )
        .onAppear(perform: {
            backClicked = false
            aviableAudio = setupAudio()
            if aviableAudio && !onPause {
                play()
            }
            NotificationCenter.default.addObserver(forName: NSNotification.Name("audioFinished"),
                                                   object: nil, queue: .main) { _ in
                if !backClicked {
                    next()
                }
            }
        })
        .onDisappear(perform: {
            player?.stop()
            player = nil
            saveCurrentTime(time: currentTime, book: book, currentChapter: currChapter)
        })
        .onReceive(
            Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()) { _ in
            updateProgress()
        }
        .navigationBarHidden(true)
        .onChange(of: scenePhase) { phase in
            switch phase {
            case .background, .inactive:
                if !backClicked {
                    saveCurrentTime(time: currentTime, book: book, currentChapter: currChapter)
                    saveForceClosed(currentChapter: currChapter, bookOrder: book.order)
                }
            case .active:
                removeCurrentTime(book: book, currentChapter: currChapter)
                removeForceClosed()
            @unknown default:
                // Handle future cases
                print("Unknown scene phase")
            }
        }
    }
}

struct AudioView_Previews: PreviewProvider {
    static var previews: some View {
        AudioView(book: Book(order: 1, name: "Matei", chapters: 28), currChapter: 3, onPause: false)
    }
}
