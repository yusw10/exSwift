//
//  AssetMenuButtonStyle.swift
//  MyAssets
//
//  Created by 유한석 on 2022/03/04.
//

import SwiftUI

struct AssetMenuButtonStyle: ButtonStyle {
    let menu: AssetMenu
    func makeBody(configuration: Configuration) -> some View {
        return VStack{
            Image(systemName: self.menu.systemImageName)
                .resizable()
                .frame(width: 30, height: 30, alignment: .center)
                .padding([.leading,.trailing],8)
            Text(self.menu.title)
                .font(.system(size: 12, weight: .bold))
        }.padding()
            .foregroundColor(Color.blue)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
    
}

struct AssetMenuButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        HStack(spacing: 24){
            Button(""){
                print("")
            }.buttonStyle(AssetMenuButtonStyle(menu: .creditScore))
            Button(""){
                print("")
            }.buttonStyle(AssetMenuButtonStyle(menu: .creditCard))
            Button(""){
                print("")
            }.buttonStyle(AssetMenuButtonStyle(menu: .bankAccount))
            Button(""){
                print("")
            }.buttonStyle(AssetMenuButtonStyle(menu: .cash))
          
        }
    }
}
