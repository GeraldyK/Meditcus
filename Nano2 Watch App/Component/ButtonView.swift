//
//  ButtonView.swift
//  Nano2 Watch App
//
//  Created by Geraldy Kumara on 20/05/23.
//

import SwiftUI

struct ButtonView: View {
    
    let title: String
    let width: Double
    
    init(title : String = "Button", width: Double = 145){
        self.title = title
        self.width = width
    }
    
    var body: some View{
        
        Text("\(title)")
            .frame(width: width, height: 30)
            .font(.system(size: 15))
            .foregroundColor(.white)
            .background(Color("BlueButton"))
            .cornerRadius(8)
    }
}

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView()
    }
}
