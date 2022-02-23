//
//  ContentView.swift
//  MyLandmarks
//
//  Created by 유한석 on 2022/02/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("하이").fontWeight(.bold)
            .foregroundColor(Color.red)
            .multilineTextAlignment(.center)
            .lineLimit(2)
            .padding([.top, .trailing], 3.0).font(.body).border(.blue, width: 4)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
