//
//  LoadingView.swift
//  Moya-RxSwift-REST-Api-Demo
//
//  Created by E7 on 2022/12/21.
//

import SwiftUI

struct LoadingView: View {
    @StateObject var vm = LoadingVM.instance
    @State private var animate: Bool = false
    @State var color: Color
    
    let style = StrokeStyle(lineWidth: 6, lineCap: .round)
    let grayColor = Color.gray
    
    var body: some View {
        ZStack {
            Circle()
                .trim(from: 0, to: 0.2)
                .stroke(
                    AngularGradient(gradient: .init(colors: [color]), center: .center),
                    style: style
                )
                .rotationEffect(Angle(degrees: animate ? 360 : 0))
                .animation(
                    .linear(duration:0.7)
                    .repeatForever(autoreverses:false),
                    value: animate
                )
            
            Circle()
                .trim(from: 0.5, to: 0.7)
                .stroke(
                    AngularGradient(gradient: .init(colors: [color]), center: .center),
                    style: style
                )
                .rotationEffect(Angle(degrees: animate ? 360 : 0))
                .animation(
                    .linear(duration:0.7)
                    .repeatForever(autoreverses:false),
                    value: animate
                )
        }
        .shadow(radius: 8, x: 20, y: 10)
        .onAppear() {
            self.animate.toggle()
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView(color: Color.gray)
    }
}
