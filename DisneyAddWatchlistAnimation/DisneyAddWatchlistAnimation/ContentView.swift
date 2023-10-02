//
//  ContentView.swift
//  DisneyAddWatchlistAnimation
//
//  Created by Anup D'Souza on 02/10/23.
//

import SwiftUI

struct LineSegment1: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        // MARK: ＋ shape's horizontal line
        path.move(to: CGPoint(x: rect.minX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        
        return path
    }
}

struct LineSegment2: Shape {
    var endPoint: CGPoint

    var animatableData: AnimatablePair<CGFloat, CGFloat> {
        get { AnimatablePair(endPoint.x, endPoint.y) }
        set {
            endPoint.x = newValue.first
            endPoint.y = newValue.second
        }
    }

    // MARK: ＋ shape's vertical line & ☑️ shape's left stroke
    func path(in rect: CGRect) -> Path {
        let start = CGPoint(x: rect.midX, y: rect.maxY)
        let end = CGPoint(x: endPoint.x * rect.width, y: endPoint.y * rect.height)
        var path = Path()
        path.move(to: start)
        path.addLine(to: end)
        return path
    }
}

struct LineSegment3: Shape {
    var animatableData: CGFloat {
        get { return progress }
        set { progress = newValue }
    }
    
    var progress: CGFloat = 0
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        // MARK: ☑️ shape's, right stroke
        path.move(to: CGPoint(x: rect.midX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX + (rect.maxX * progress), y: rect.minY))
        return path
    }
}

struct ContentView: View {
    @State private var drawProgress: CGFloat = 0.0
    @State private var completed: Bool = false
    
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 5)
                .frame(width: 300, height: 300)
                .foregroundColor(.red)
                .overlay {
                    ZStack {
                        LineSegment1()
                            .stroke(.white, lineWidth: 4.0)
                            .opacity(completed ? 0 : 1)
                            .frame(width: 200, height: 200)
                        LineSegment2(endPoint: CGPoint(
                            x: completed ? 0.0 : 0.5,
                            y: completed ? 0.5 : 0.0))
                        .stroke(completed ? .yellow : .white, lineWidth: 4.0)
                        .frame(width: 200, height: 200)
                        LineSegment3(progress: drawProgress)
                            .stroke(.yellow, lineWidth: 4.0)
                            .opacity(completed ? 1 : 0)
                            .frame(width: 200, height: 200)
                    }
                }
            
            Button(completed ? "Incomplete" : "Complete") {
                withAnimation(.easeInOut(duration: 0.5)) {
                    drawProgress = 1.0
                    completed.toggle()
                }
            }
            .buttonStyle(.borderedProminent)
            Spacer()
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
