//
//  TowerView.swift
//  AugmentedRealitySupervisorIOS
//
//  Created by Rodion Hladchenko on 05.09.2024.
//

import Foundation
import SwiftUI

struct TowerView: View {
    var body: some View {
        VStack(spacing: 0) {
            Capsule()
                .fill(.pink)
                .frame(width: 240, height: 80)
            Capsule()
                .fill(.gray)
                .frame(width: 240, height: 80)
            Capsule()
                .fill(.yellow)
                .frame(width: 240, height: 80)
            Capsule()
                .fill(.brown)
                .frame(width: 240, height: 80)
        }
    }
}

struct Tower_Previews: PreviewProvider {
    static var previews: some View {
        TowerView()
    }
}
