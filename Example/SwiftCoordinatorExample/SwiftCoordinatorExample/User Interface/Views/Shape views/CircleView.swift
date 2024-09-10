//
//  CircleView.swift
//  AugmentedRealitySupervisorIOS
//
//  Created by Rodion Hladchenko on 06.09.2024.
//

import SwiftUI

protocol CircleViewDelegate {
    func onDone()
}

struct CircleView: View {
    
    var coordinator: CircleViewDelegate
    
    var body: some View {
        VStack {
            Spacer()
            Circle()
                .fill(.blue)
                .frame(width: 200, height: 200)
            Spacer()
            Button {
                coordinator.onDone()
            } label: {
                Text("Done")
            }
            .buttonStyle(.borderedProminent)
        }
    }
}

struct CircleView_Previews: PreviewProvider {
    static var previews: some View {
        CapsuleView()
    }
}
