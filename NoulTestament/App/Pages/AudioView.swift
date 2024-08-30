//
//  AudioView.swift
//  NoulTestament
//
//  Created by Vadim on 29/08/2024.
//

import SwiftUI

struct AudioView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        Text("Audio View Content")
            .navigationBarHidden(true)
//            .gesture(
//                DragGesture()
//                    .onChanged { value in
//                        if value.translation.width > 70 {
//                            presentationMode.wrappedValue.dismiss()
//                        }
//                    }
//            )
    }
}

struct AudioView_Previews: PreviewProvider {
    static var previews: some View {
        AudioView()
    }
}
