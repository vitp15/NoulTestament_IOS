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
    @State var width : CGFloat = 0
    
    var body: some View {
        VStack {
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
            
            VStack {
                Text(book.name)
                    .font(.roboto, size: 40)
                    .fontWeight(.medium)
                    .minimumScaleFactor(0.75)
                    .foregroundColor(Color(.onSurface))
                
                Text(String(currChapter))
                    .font(.roboto, size: 64)
                    .fontWeight(.medium)
                    .minimumScaleFactor(0.75)
                    .foregroundColor(Color(.onSurface))
                    .padding(.top, 10)
            }
            Spacer()
            
            HStack {
                Image(.replay_5)
                Spacer()
                Image(.forward_5)
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 32)
            
            HStack(alignment: .bottom, spacing: 0, content: {
                Image(.previous)
                Spacer()
                Image(.play)
                Spacer()
                Image(.next)
            })
            .padding(.horizontal, 16)
            .padding(.bottom, 32)
            
            VStack {
                ZStack(alignment: .leading) {
                    Capsule().fill(Color(.tertiaryFixedDim)).frame(height: 7)
                    Capsule().fill(Color(.tertiary)).frame(width: self.width, height: 7)
                }
                .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local)
                            .onChanged({ (value) in
                                let x = value.location.x
                                self.width = value.location.x
                            }).onEnded({ (value) in
                                let x = value.location.x
                                let screen = UIScreen.main.bounds.width - 32
                                let percent = x / screen
                                //                            self.player.currentTime = Double(percent) * self.player.duration
                            }))
                
                HStack {
                    Text("1:23")
                        .font(.roboto, size: 16)
                        .fontWeight(.regular)
                        .foregroundColor(Color(.tertiary))
                    Spacer()
                    Text("6:44")
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
                .scaledToFill()
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
        .navigationBarHidden(true)
    }
}

struct AudioView_Previews: PreviewProvider {
    static var previews: some View {
        AudioView(book: Book(order: 1, name: "Matei", chapters: 28), currChapter: 3)
    }
}
