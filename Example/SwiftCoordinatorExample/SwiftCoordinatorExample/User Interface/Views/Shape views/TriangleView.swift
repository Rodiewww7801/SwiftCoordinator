//
//  TriangleView.swift
//  AugmentedRealitySupervisorIOS
//
//  Created by Rodion Hladchenko on 05.09.2024.
//

import SwiftUI

struct TriangleView: View {
    var body: some View {
        VStack {
            Triangle()
                .fill(.green)
                .frame(width: 200, height: 200)
        }
    }
}

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))

        return path
    }
}

struct Triangle_Previews: PreviewProvider {
    static var previews: some View {
        TriangleView()
    }
}
