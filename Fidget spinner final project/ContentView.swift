//
//  ContentView.swift
//  Fidget spinner final project
//
//  Created by Student on 5/18/22.
//

import SwiftUI

struct ContentView: View {
    @State private var rotation = 0.0
    @State private var dragVelocity = 0.0
    @State private var dragDuration = 0.0
    var body: some View {
        Text("Virtual Fidget Spinner")
            .font(.title)
        Spacer()
        Image("Red Spinner")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 300)
            .rotationEffect(Angle(degrees: rotation))
            .gesture(DragGesture(minimumDistance: 1, coordinateSpace: .local).onChanged({
                value in
                let valueDescription = "\(value)"
                //intercept string
                let start = valueDescription.range(of: "valuePerSecond: (")
                let end = valueDescription.range(of: ")))")
                let arr = String(valueDescription[(start!.upperBound)..<(end!.lowerBound)]).components(separatedBy: ",")
                dragVelocity += Double(arr.first!)!
                dragDuration += 1.0
            }).onEnded({ value in
                withAnimation(.easeOut(duration: 5)) {
                    rotation -= dragVelocity / dragDuration
                }
                dragVelocity = 0.0
                dragDuration = 0.0
            }))
        Spacer()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
