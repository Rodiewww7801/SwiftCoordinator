//
//  ElipseView.swift
//  AugmentedRealitySupervisorIOS
//
//  Created by Rodion Hladchenko on 06.09.2024.
//

import SwiftUI

struct ElipseView: View {
    var body: some View {
        VStack {
            Ellipse()
                .fill(.gray)
                .frame(width: 200, height: 100)
        }
    }
}

struct ElipseView_Previews: PreviewProvider {
    static var previews: some View {
        ElipseView()
    }
}
