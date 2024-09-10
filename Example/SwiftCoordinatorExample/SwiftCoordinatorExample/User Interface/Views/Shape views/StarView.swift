//
//  StarView.swift
//  AugmentedRealitySupervisorIOS
//
//  Created by Rodion Hladchenko on 05.09.2024.
//

import SwiftUI

struct StarView: View {
    var body: some View {
        VStack {
            Star()
                .fill(.yellow)
                .frame(width: 200, height: 200)
        }
    }
}

struct Star: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let centerX = rect.width / 2
        let centerY = rect.height / 2
        let pointsOnStar = 5
        let skipPointsBy = 2
        let radius = min(rect.width, rect.height) / 2
        
        let angle = CGFloat.pi * 2 / CGFloat(pointsOnStar * skipPointsBy)
        var currentAngle: CGFloat = -.pi / 2
        
        var firstPoint = true
        
        for i in 0..<pointsOnStar * skipPointsBy {
            let pointRadius: CGFloat = i % skipPointsBy == 0 ? radius : radius / 2
            let x = centerX + cos(currentAngle) * pointRadius
            let y = centerY + sin(currentAngle) * pointRadius
            
            if firstPoint {
                path.move(to: CGPoint(x: x, y: y))
                firstPoint = false
            } else {
                path.addLine(to: CGPoint(x: x, y: y))
            }
            
            currentAngle += angle
        }
        
        path.closeSubpath()
        
        return path
    }
}

struct StarView_Previews: PreviewProvider {
    static var previews: some View {
        StarView()
    }
}
