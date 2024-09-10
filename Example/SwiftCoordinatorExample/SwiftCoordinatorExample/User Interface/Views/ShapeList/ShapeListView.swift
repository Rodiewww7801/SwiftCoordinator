//
//  ShapeListView.swift
//  AugmentedRealitySupervisorIOS
//
//  Created by Rodion Hladchenko on 05.09.2024.
//

import SwiftCoordinator
import Foundation
import SwiftUI

protocol ShapeListViewDelegate: AnyObject {
    func presentSimpleShapes()
    func presentCustomShapes()
    func presentFeaturedShape(for route: NavigationRoute)
    func onTabs()
}

struct ShapeListView: View {
    var coordinator: ShapeListViewDelegate?
    @StateObject var viewModel = ViewModel()

    var body: some View {
        List {
            Button {
                viewModel.didTapBuiltIn()
            } label: {
                Text("Simple")
            }
            Button {
                viewModel.didTapCustom()
            } label: {
                Text("Custom")
            }
            Button {
                viewModel.didTapFeatured()
            } label: {
                Text("Featured")
            }
            Button {
                viewModel.didTapTabs()
            } label: {
                Text("Tabs")
            }
        }
        .onAppear {
            viewModel.coordinator = coordinator
        }
    }
}

extension ShapeListView {
    @MainActor class ViewModel: ObservableObject {
        var coordinator: ShapeListViewDelegate?

        func didTapBuiltIn() {
            coordinator?.presentSimpleShapes()
        }

        func didTapCustom() {
            coordinator?.presentCustomShapes()
        }

        func didTapFeatured() {
            let routes: [NavigationRoute] = [
                SimpleShapesRoute.circle,
                CustomShapesRoute.tower,
                SimpleShapesRoute.capsule
            ]

            guard let route = routes.randomElement() else {
                return
            }
            
            coordinator?.presentFeaturedShape(for: route)
        }
        
        func didTapTabs() {
            coordinator?.onTabs()
        }
    }
}

struct ShapesView_Previews: PreviewProvider {
    static var previews: some View {
        ShapeListView()
    }
}
