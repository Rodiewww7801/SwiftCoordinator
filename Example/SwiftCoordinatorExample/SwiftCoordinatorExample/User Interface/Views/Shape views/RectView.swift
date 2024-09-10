//
//  RectView.swift
//  AugmentedRealitySupervisorIOS
//
//  Created by Rodion Hladchenko on 05.09.2024.
//

import Foundation
import SwiftUI

protocol RectViewDelegate: AnyObject {
    func dismiss()
}

struct RectView: View {
    var coordinator: RectViewDelegate?
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Rectangle()
                    .fill(.yellow)
                    .frame(width: 200, height: 200)
                Spacer()
            }
            Spacer()
                .frame(height: 16)
            Text("Tap to dismiss.")
            Spacer()
        }
        .background(.white)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onTapGesture { [weak coordinator] in
            coordinator?.dismiss()
        }
    }
}

struct RectView_Previews: PreviewProvider {
    static var previews: some View {
        RectView()
    }
}
