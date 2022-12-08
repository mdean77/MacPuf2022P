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
                    VStack{
                        VStack {
                            Text("MacPuf")
                                .font(.system(size: 70))
                            Text("Computer Simulation of Gas Exchange and Circulation\n")
                                .font(.system(size: 25))
                            Text("This is an educational simulation based on a simplified mathematical\n model and is intended to increase understanding of the physiology of gas\n exchange and circulation. It is not intended for any clinical purposes. ")
                                .font(.system(size:20))
                        } .padding(.bottom)
                            .padding(.leading)
                            .padding(.trailing)
                            .foregroundColor(.black.opacity(0.80))
                            .background(.yellow)
                        
                        Button{
                            self.isActive = true}
                    label: {Text("Acknowledge")
                    }        .buttonStyle(.bordered)
                            .foregroundColor(.white)
                            .background(.blue)
                            .font(.title)
                            .padding()
                    }
                }
                .scaleEffect(size)
                .opacity(opacity)
                .onAppear(){
                    withAnimation(.easeIn(duration: 2)){
                        self.size = 1.0
                        self.opacity = 1.0
                    }
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
