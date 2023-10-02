//
//  ContentView.swift
//  DisneyAddWatchlistAnimation
//
//  Created by Anup D'Souza on 02/10/23.
//

import SwiftUI

struct AddWatchlist: Shape {
    var animatableData: CGFloat {
        get { return progress }
        set { progress = newValue }
    }
    
    var progress: CGFloat = 0
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.minX, y: rect.midY))
//        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.minX + (rect.maxX * progress), y: rect.midY))
        
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
//        path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY + (rect.maxY * progress)))
        
        return path
    }
}

struct ContentView: View {
    @State private var drawProgress: CGFloat = 0.0
    
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 5)
                .frame(width: 300, height: 300)
                .foregroundColor(.red)
                .overlay {
                    AddWatchlist(progress: drawProgress)
                        .stroke(.black, lineWidth: 10.0)
                        .frame(width: 200, height: 200)
                }
        }
        .onAppear {
            withAnimation(.linear(duration: 2.0)) {
                drawProgress = 1.0
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
