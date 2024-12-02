//
//  PlaceHolderView.swift
//  NewsApp
//
//  Created by Puneet on 01/12/24.
//

import SwiftUI

struct PlaceHolderView: View {
    let text: String
    let image: Image?
    
    var body: some View {
        VStack(spacing: 8) {
            Spacer()
            if let image = self.image {
                image
                    .imageScale(.large)
                    .font(.system(size: 52))
            }
            Text(text)
            Spacer()
        }
    }
}

#Preview {
    PlaceHolderView(text: "", image: Image(systemName: "circle"))
}
