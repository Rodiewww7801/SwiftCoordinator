//
//  CapsuleView.swift
//  AugmentedRealitySupervisorIOS
//
//  Created by Rodion Hladchenko on 06.09.2024.
//

import SwiftUI

struct CapsuleView: View {
    var body: some View {
        VStack {
            Capsule()
                .fill(.pink)
                .frame(width: 200, height: 50)
        }
    }
}

struct CapsuleView_Previews: PreviewProvider {
    static var previews: some View {
        CapsuleView()
    }
}
