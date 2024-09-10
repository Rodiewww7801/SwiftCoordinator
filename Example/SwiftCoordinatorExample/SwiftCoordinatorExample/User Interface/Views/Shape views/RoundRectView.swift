//
//  RoundRectView.swift
//  AugmentedRealitySupervisorIOS
//
//  Created by Rodion Hladchenko on 06.09.2024.
//

import SwiftUI

struct RoundRectView: View {
    var onDismiss: (()->Void)?
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(.red)
                .frame(width: 200, height: 200)
            Text("Tap to dismiss.")
                .padding()
        }.padding()
            .onTapGesture {
                self.onDismiss?()
            }
    }
}

struct RoundRectView_Previews: PreviewProvider {
    static var previews: some View {
        RoundRectView()
    }
}
