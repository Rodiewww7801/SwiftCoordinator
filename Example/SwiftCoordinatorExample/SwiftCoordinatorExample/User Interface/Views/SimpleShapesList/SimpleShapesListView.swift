//
//  SimpleShapesListView.swift
//  AugmentedRealitySupervisorIOS
//
//  Created by Rodion Hladchenko on 05.09.2024.
//

import Foundation
import SwiftUI

protocol SimpleShapesViewDelegate: AnyObject {
    func presentRect()
    func presentRoundedRect()
    func presentCapsule()
    func presentEllipse()
    func presentCircle()
}

struct SimpleShapesListView: View {
    var coordinator: SimpleShapesViewDelegate?
    @StateObject var viewModel = ViewModel()

    var body: some View {
        List {
            Button {
                viewModel.didTapRectangle()
            } label: {
                Text("Rectangle")
            }
            Button {
                viewModel.didTapRoundedRectangle()
            } label: {
                Text("RoundedRectangle")
            }
            Button {
                viewModel.didTapCapsule()
            } label: {
                Text("Capsule")
            }
            Button {
                viewModel.didTapEllipse()
            } label: {
                Text("Ellipse")
            }
            Button {
                viewModel.didTapCircle()
            } label: {
                Text("Circle")
            }
        }
        .onAppear {
            viewModel.coordinator = coordinator
        }
    }
}

extension SimpleShapesListView {
    @MainActor class ViewModel: ObservableObject {
        var coordinator: SimpleShapesViewDelegate?

        func didTapRectangle() {
           // coordinator?.handle(SimpleShapesAction.rect)
            coordinator?.presentRect()
        }

        func didTapRoundedRectangle() {
            //coordinator?.handle(SimpleShapesAction.roundedRect)
            coordinator?.presentRoundedRect()
        }

        func didTapCapsule() {
           // coordinator?.handle(SimpleShapesAction.capsule)
            coordinator?.presentCapsule()
        }

        func didTapEllipse() {
            //coordinator?.handle(SimpleShapesAction.ellipse)
            coordinator?.presentEllipse()
        }

        func didTapCircle() {
            //coordinator?.handle(SimpleShapesAction.circle)
            coordinator?.presentCircle()
        }
    }
}

struct SimpleShapesView_Previews: PreviewProvider {
    static var previews: some View {
        SimpleShapesListView()
    }
}

