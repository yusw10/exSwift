//
//  MyView.swift
//  SwiftUIPractice
//
//  Created by 유한석 on 2022/03/02.
//

import SwiftUI

struct MyView: View {
    //바디는 필수적.
    var body: some View {
        VStack{
            Text("Hello world").font(.title)
        }
    }
}

struct MyView_Previews: PreviewProvider {
    static var previews: some View {
        MyView()
    }
}
