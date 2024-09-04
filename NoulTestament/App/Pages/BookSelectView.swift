//
//  ContentView.swift
//  NoulTestament
//
//  Created by Vadim on 28/08/2024.
//

import SwiftUI
import UserNotifications

struct BookSelectView: View {
    @State var goToLastAudio: Bool = false
    @State var lastOrder: Int = 1
    @State var lastChapter: Int = 1
    
    init() {
        // Customize the navigation bar appearance
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(.seed) ?? UIColor.green
        let onPrimaryColor = UIColor(.onPrimary) ?? UIColor.white
        let customFont = UIFont.roboto(size: 22, weight: .medium)
        appearance.titleTextAttributes = [
            .font: customFont,
            .foregroundColor: onPrimaryColor
        ]
        appearance.largeTitleTextAttributes = [.foregroundColor: onPrimaryColor]
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                NavigationLink(
                    destination: AudioView(book: Storage.instance.books[lastOrder - 1],
                                           currChapter: lastChapter, onPause: true),
                    isActive: $goToLastAudio,
                    label: { EmptyView() }
                )
                List {
                    ForEach(Storage.instance.books, id: \.order) { book in
                        ZStack {
                            NavigationLink(
                                destination: ChapterSelectView(book: book)
                                    .navigationBarBackButtonHidden(true),
                                label: {}).hidden()
                            BookItemView(name: book.name)
                        }
                        .listRowBackground(Color.clear)
                    }
                    .listRowInsets(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                }
                .listStyle(PlainListStyle())
                .background(
                    ZStack {
                        Image(.books_walpaper)
                            .resizable()
                            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                            .aspectRatio(contentMode: .fill)
                            .scaleEffect(/*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/, anchor: .bottomTrailing)
                            .edgesIgnoringSafeArea([.leading, .trailing, .bottom])
                        
                        Color(.above_walpapers)
                            .edgesIgnoringSafeArea(.all)
                    })
            }
            .navigationTitle("Noul Testament")
            .navigationBarTitleDisplayMode(.inline)
            .frame(maxWidth: 700)
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear(perform: {
            handleNotifications()
            if let lastClosed = loadLastForceClosed() {
                removeForceClosed()
                let components = lastClosed.split(separator: " ")
                if components.count == 2 {
                    lastOrder = Int(components[0]) ?? 1
                    lastChapter = Int(components[1]) ?? 1
                    goToLastAudio = true
                }
            } else {
                goToLastAudio = false
            }
        })
    }
}

struct BookSelectView_Previews: PreviewProvider {
    static var previews: some View {
        BookSelectView()
    }
}
