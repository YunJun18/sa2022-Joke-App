//
//  ResponseView.swift
//  Joke App
//
//  Created by T Krobot on 15/6/22.
//

import SwiftUI

struct ResponseView: View {
    
    var isPositive: Bool
    
    var body: some View {
        VStack {
            Image(isPositive ? "happyChase" : "sadRocky")
                .resizable()
                .scaledToFit()
                .frame(width: 200)
            Text(isPositive ? "Yay! Thank you" : "You are awful and should feel bad")
        }
    }
}

struct ResponseView_Previews: PreviewProvider {
    static var previews: some View {
        ResponseView(isPositive: true)
        ResponseView(isPositive: false)
    }
}
