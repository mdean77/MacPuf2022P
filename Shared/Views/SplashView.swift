//
//  SplashView.swift
//  MacPuf2022P
//
//  Created by J Michael Dean on 12/4/22.
//  Hope to use this to start up MacPuf
//

import SwiftUI

struct SplashView: View {
    @State private var isActive = false
    @State private var size = 0.5
    @State private var opacity = 0.3
    @StateObject var simulator = Simulator()
    var body: some View {
        if isActive {
            ContentView()
                .environmentObject(simulator)
        } else {
            VStack{
                ZStack{
                    
                    Color.blue
                        .ignoresSafeArea()
                    Image("puf4")
                        .scaledToFit()
                    VStack {
                        Text("MacPuf")
                            .font(.system(size: 80))
                           Text("Computer Simulation of Gas Exchange and Circulation")
                            .font(.system(size: 25))

                    } .padding()
                        .foregroundColor(.black.opacity(0.80))
                        .background(.yellow)
                }
                .scaleEffect(size)
                .opacity(opacity)
                .onAppear(){
                    withAnimation(.easeIn(duration: 3)){
                        self.size = 1.0
                        self.opacity = 1.0
                    }
                }
            }
            .onAppear(){
                DispatchQueue.main.asyncAfter(deadline: .now() + 5.0){
                    self.isActive = true
                }
            }
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
